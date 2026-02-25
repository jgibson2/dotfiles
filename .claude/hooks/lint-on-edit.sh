#!/bin/bash
# PostToolUse hook: run linter after Edit/Write operations.

FILE_PATH=$(jq -r '.tool_input.file_path // empty' < /dev/stdin)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

case "$FILE_PATH" in
  *.py)
    if command -v ruff >/dev/null 2>&1; then
      OUTPUT=$(ruff check --fix "$FILE_PATH" > /dev/null 2>&1)
    elif command -v uv >/dev/null 2>&1; then
      OUTPUT=$(uv run ruff check --fix "$FILE_PATH" > /dev/null 2>&1)
    else
      exit 0
    fi
    ;;
  *.c|*.h|*.cpp|*.hpp|*.cc|*.cxx)
    command -v clang-tidy >/dev/null 2>&1 || exit 0
    OUTPUT=$(clang-tidy --fix "$FILE_PATH" > /dev/null 2>&1)
    ;;
  *.ts|*.tsx)
    command -v npx >/dev/null 2>&1 || exit 0
    DIR=$(dirname "$FILE_PATH")
    TSCONFIG=""
    while [ "$DIR" != "/" ]; do
      [ -f "$DIR/tsconfig.json" ] && TSCONFIG="$DIR/tsconfig.json" && break
      DIR=$(dirname "$DIR")
    done
    [ -z "$TSCONFIG" ] && exit 0
    OUTPUT=$(npx tsc --noEmit --project "$TSCONFIG" 2>&1)
    ;;
  *)
    exit 0
    ;;
esac

if [ $? -ne 0 ]; then
  echo "$OUTPUT" >&2
  exit 2
fi
exit 0
