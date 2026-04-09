## Task Tracking Workflow

This project uses a folder-based task tracking system to maintain a clear history of all development work. This allows developers and AI assistants to track changes, revert if needed, and maintain documentation of completed work.

### Directory Structure

```
task/                                      # Task tracking
  ├── task-johndoe-001-feature-name.md     # Active/ongoing tasks
  ├── task-johndoe-002-bug-fix.md          # (grouped by username)
  ├── task-sarasmith-001-new-feature.md
  ├── task-claude-001-ai-implementation.md
  ├── ...
  └── completed_task/                      # Completed and archived tasks
      ├── task-johndoe-001-feature-name.md
      ├── task-mprabhat-001-refactoring.md
      └── ...
```

**Note**: The `task/` folder (including `task/completed_task/` subfolder) should be committed to git to maintain project history.

**Naming Convention**: `task-<username>-<number>-<description>.md`
- Files automatically group by developer when sorted alphabetically
- Each developer maintains their own numbering sequence (001, 002, 003...)

### Starting a New Task

#### For Claude Code / AI Assistants

When the user says "new task" or similar, follow this workflow:

1. **Auto-Detect Username from Git Config**

   Automatically extract username using this priority:

   **Primary method:**
   ```bash
   git config user.name
   ```
   Sanitize the result:
   - Convert to lowercase
   - Remove spaces, dots, special characters
   - Keep only alphanumeric and hyphens
   - Limit to 20 characters

   Examples:
   - "mprabhat" → "mprabhat"
   - "John Doe" → "johndoe"
   - "Sarah.Smith" → "sarahsmith"

   **Fallback method (if user.name is not set):**
   ```bash
   git config user.email
   # Extract username part before @
   # Example: "mprabhat@example.com" → "mprabhat"
   ```

   **Last resort:** If both methods fail, ask the user for their preferred identifier.

   For Claude Code tasks, use: `claude`

2. **Ask for Task Details**

   Ask the user:
   ```
   What's the task name/title and brief description?
   ```

3. **User Provides Details**

   Example response from user:
   ```
   Add user profile editing - implement profile update functionality
   ```

4. **Determine Task Number**

   Check both `task/` and `task/completed_task/` folders for the highest task number **for that specific username**, then increment by 1.

   Example: If `task-johndoe-003-*.md` is the highest, next would be `004`.

5. **Create Git Branch**
   ```bash
   git checkout -b task/<username>-<number>-<brief-description>
   ```

   Branch naming convention:
   - `task/johndoe-001-add-user-profile-editing` (for features)
   - `task/sarasmith-001-fix-listing-search-bug` (for bug fixes)
   - `task/claude-001-refactor-api-client` (for refactoring)

6. **Create Task Documentation File**

   Create a markdown file in the `task/` folder:
   ```bash
   # File: task/task-johndoe-001-add-user-profile-editing.md
   ```

   Use this template:
   ```markdown
   # Task johndoe-001: Add User Profile Editing

   **Status**: In Progress
   **Branch**: task/johndoe-001-add-user-profile-editing
   **Started**: 2026-04-09
   **Assigned to**: johndoe

   ## Description
   Implement profile update functionality for users.

   ## Requirements
   - [ ] Create profile edit form UI
   - [ ] Implement API endpoint for profile update
   - [ ] Add form validation
   - [ ] Test profile update flow

   ## Files Modified
   (Will be updated as work progresses)

   ## Changes Made

   ### [Date/Time] - Initial Setup
   (Will be updated as work progresses)

   ## Testing Notes
   (Will be updated after testing)

   ## Issues Encountered
   (Will be documented if any issues arise)

   ## Rollback Instructions
   If this task needs to be reverted:
   ```bash
   git checkout staging
   git branch -D task/johndoe-001-add-user-profile-editing
   ```

   ## Related Tasks
   - Depends on: None
   ```

7. **Begin Working**

   Start implementing the task, updating the task file regularly with:
   - Files modified and why
   - Changes made with timestamps
   - Any decisions or trade-offs
   - Issues encountered and how resolved

8. **Commit Frequently**
   ```bash
   git add .
   git commit -m "task-johndoe-001: Add profile edit form UI"
   git commit -m "task-johndoe-001: Implement API endpoint"
   git commit -m "task-johndoe-001: Add form validation"
   ```

   Commit message format: `task-<username>-<number>: <brief description>`

### When Claude Finishes Implementation

When all work is complete:

1. **Run Basic Verification**
   ```bash
   # Frontend
   cd next-app
   npm run lint
   npm run build  # if applicable

   # Backend
   cd laravel-api
   php artisan test  # if applicable
   composer pint     # code formatting
   ```

2. **Update Task File**
   - Mark all requirements as complete
   - Document all files modified
   - Add testing notes
   - Document any issues encountered

3. **Commit and Push to Task Branch**
   ```bash
   git add .
   git commit -m "task-johndoe-001: Final implementation and documentation"
   git push origin task/johndoe-001-add-user-profile-editing
   ```

4. **Notify Developer**

   Inform the user:
   ```markdown
   ✅ Implementation complete and pushed to branch: task/johndoe-001-add-user-profile-editing

   **Summary**: [Brief description of what was done]

   **Testing Done**:
   - Linting: passed/failed
   - Build: passed/failed
   - Manual testing: [describe what was tested]

   **Files Modified**: [count] files
   - List key files changed

   **Documentation**: See task/task-johndoe-001-add-user-profile-editing.md for full details

   **Ready for your review and testing.**
   ```

5. **Wait for Developer Approval**

   **IMPORTANT**: Task file stays in `task/` folder. Do NOT move it to `completed_task/` yet.

### When Developer Approves Completion

After the developer reviews and tests the changes:

1. **Developer Says "completed" or "mark complete"**

2. **Claude Moves Task File to Completed**
   ```bash
   git mv task/task-johndoe-001-add-user-profile-editing.md task/completed_task/
   git add .
   git commit -m "Archive completed task-johndoe-001"
   git push origin task/johndoe-001-add-user-profile-editing
   ```

3. **Task Branch Stays Alive**

   The task branch remains and can be merged to staging by the developer at any time.

### Task File Best Practices

1. **Be Detailed**: Future developers (or AI) should understand what was done and why
2. **Document Decisions**: Explain architectural choices or trade-offs
3. **Track All Changes**: List every file modified with a brief explanation
4. **Include Context**: Link to related issues, tickets, or documentation
5. **Add Rollback Steps**: Make it easy to revert if needed
6. **Update Regularly**: Keep the task file current as work progresses

### Emergency Rollback

If a task needs to be reverted:

1. Find the task file in `task/completed_task/` for rollback instructions
2. Create a new revert task:
   ```bash
   git checkout -b task/<username>-<number>-revert-user-profile-editing
   ```
   Example: `task/johndoe-005-revert-user-profile-editing`
3. Revert the changes manually or using git:
   ```bash
   git revert <commit-hash-range>
   ```
4. Document the revert in a new task file explaining why

### Task Numbering

- **Per-Developer Numbering**: Each developer maintains their own sequence
  - johndoe: 001, 002, 003, ...
  - sarasmith: 001, 002, 003, ...
  - claude: 001, 002, 003, ...
- Check both `task/` and `task/completed_task/` folders for the highest number **for that specific username**
- Pad with zeros for better sorting (001 not 1)
- Example: If `task-johndoe-003-*.md` exists, next johndoe task would be `004`

### Simplified Workflow Summary

```
User says "new task"
  ↓
Claude auto-detects username from git config
  ↓
Claude asks for task name/description
  ↓
User provides details
  ↓
Claude creates branch + task file (task-username-001-...)
  ↓
Claude implements and commits frequently
  ↓
Claude finishes, pushes to task branch
  ↓
Claude notifies developer (task file stays in task/)
  ↓
Developer reviews/tests
  ↓
Developer says "completed"
  ↓
Claude moves file to completed_task/
  ↓
Claude pushes to same task branch
  ↓
Developer merges to staging when ready
```

### AI Assistant Responsibilities vs Developer Responsibilities

**Claude Code / AI Does:**
- ✅ Auto-detect username from git config (user.name or user.email)
- ✅ Ask for task name and description
- ✅ Determine task number for that username
- ✅ Create task branch with username prefix
- ✅ Create and update task documentation file
- ✅ Write code and make changes
- ✅ Run basic tests (lint, build, unit tests)
- ✅ Commit and push to task branch
- ✅ Notify developer when implementation complete
- ✅ Move task file to completed_task/ when developer approves
- ✅ Push completion commit to task branch

**Developer Does:**
- ✅ Provide task name and description
- ✅ Review code quality
- ✅ Test on real devices/browsers
- ✅ Approve completion ("completed" or "mark complete")
- ✅ Merge task branch to staging when satisfied
- ✅ Deploy to production if needed
- ✅ Delete branches if desired (optional)

### Critical Git Rules for AI

**DO NOT** perform these git operations unless explicitly requested by the user:
- `git checkout <branch>` - Let developer control branch switching (except when creating new task branch)
- `git reset` - Destructive operation, developer only
- `git merge` - Developer controls merges
- `git rebase` - Developer controls rebasing
- `git stash` - Let developer manage stash
- `git branch -d/-D` - Let developer delete branches

**AI should only**:
- Create new task branches when user starts a task (`git checkout -b task/...`)
- Add files with `git add`
- Commit changes with `git commit`
- Push to the current task branch with `git push origin <task-branch>`
- Move task files when developer approves completion (`git mv`)
- Check status with `git status`, `git log`, `git diff`

**Key Differences from Traditional Workflow**:
- ❌ No PR creation - developer merges when ready
- ❌ No branch cleanup - branches stay alive
- ✅ Task file moves only after developer approval
- ✅ All work pushed to task branch (not staging)
- ✅ Fast iteration without PR bottlenecks
