#!/bin/bash
# SessionStart(compact) hook: inject saved session state after compaction.
# stdout text from SessionStart hooks is added to Claude's context.

STATE="${CLAUDE_PROJECT_DIR:-.}/.claude/COMPACT_STATE.md"

[ ! -f "$STATE" ] && exit 0

echo "=== RESTORED SESSION CONTEXT ==="
cat "$STATE"
echo "=== END RESTORED SESSION CONTEXT ==="
echo ""
echo "Continue from where you left off based on the status above."
exit 0
