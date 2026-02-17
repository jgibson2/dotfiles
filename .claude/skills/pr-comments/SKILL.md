---
name: pr-comments
description: Retrieve and summarize review comments from a GitHub pull request.
argument-hint: "[PR number or URL]"
---

# Get PR Review Comments

Fetch all review comments for a pull request and summarize what needs to be addressed.

## Steps

1. **Parse the PR reference** from `$ARGUMENTS`. Accept a PR number, URL, or `OWNER/REPO#NUM` format. If just a number, use the current repo.

2. **Fetch comments**:
   ```bash
   gh pr view $PR --json reviewDecision,reviews,comments
   gh api repos/OWNER/REPO/pulls/PR/comments --jq '.[] | {id: .id, user: .user.login, path: .path, line: .line, body: .body, in_reply_to_id: .in_reply_to_id}'
   ```

3. **Summarize** the feedback grouped by file, distinguishing:
   - Unresolved top-level comments (`in_reply_to_id == null`) — these likely need action
   - Reply threads — check if the conversation concluded or if action is still needed
   - General PR-level comments (not attached to a file)

4. **Output** a concise summary:
   - Overall review decision (approved, changes requested, pending)
   - List of actionable comments with file path, line, and what's being asked
   - Any comments that appear already addressed
