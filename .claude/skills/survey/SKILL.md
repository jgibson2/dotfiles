---
name: survey
description: Explore the current project and append key findings to CLAUDE.md for future sessions.
argument-hint: "[target file path]"
---

# Survey Project

Explore the current project's codebase and append important findings to a CLAUDE.md file so future Claude sessions start with useful context.

## Steps

1. **Determine target file** from `$ARGUMENTS`. Default: `.claude/CLAUDE.md` in the project root. If the file doesn't exist, create it.

2. **Read existing content** of the target file. Note what's already documented so you don't duplicate it.

3. **Explore the project** to discover:
   - **Project type & stack**: language(s), framework(s), build system, package manager (check `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `Makefile`, `Gemfile`, etc.)
   - **Structure**: key top-level directories and what they contain
   - **Dev workflow**: how to build, test, lint, format, run (check scripts in manifests, `Makefile`, CI config)
   - **Conventions**: naming patterns, code organization, architecture patterns observed
   - **Key dependencies**: important libraries/frameworks (not every transitive dep)

4. **Append a `# Project` section** to the target file with your findings. If a `# Project` section already exists, replace it. Keep everything concise — bullet points, not paragraphs. Only include things that are genuinely useful for a developer (or Claude) working in this repo.

5. **Show the user** what was added by displaying the new `# Project` section content.

## Output format

The appended section should look like:

```markdown
# Project

## Stack
- [language, framework, key tools]

## Structure
- `dir/` — purpose
- ...

## Dev Workflow
- Build: `command`
- Test: `command`
- Lint: `command`

## Conventions
- [observed patterns worth noting]

## Key Dependencies
- [important libs and what they're used for]
```

Omit any subsection where there's nothing meaningful to report. Do not repeat information already present in the file.
