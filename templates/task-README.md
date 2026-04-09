# Active Tasks

This folder contains documentation for all currently active/in-progress tasks.

## Purpose

Each task file tracks:
- What is being worked on
- Files being modified
- Changes made with timestamps
- Testing notes
- Issues encountered

## Task File Naming

**Format**: `task-<username>-<number>-<brief-description>.md`

The username comes FIRST to automatically group tasks by developer when sorted alphabetically.

**Username Auto-Detection**: The username is automatically extracted from your local git configuration using `git config user.name` (or `user.email` as fallback). No manual input required!

### Examples:

**Human Developers:**
- `task-johndoe-001-add-user-authentication.md`
- `task-johndoe-002-implement-profile-editing.md`
- `task-sarasmith-001-fix-listing-search-bug.md`
- `task-mprabhat-001-refactor-api-client.md`

**AI Assistant:**
- `task-claude-001-add-pagination-component.md`
- `task-claude-002-optimize-database-queries.md`

### Benefits:
- Files automatically group by developer when sorted
- Easy filtering: `ls task-johndoe-*` shows all tasks for that developer
- Each developer maintains their own numbering sequence
- No number conflicts between developers

## Workflow

1. Say "new task" - Claude will automatically detect your username from git config
2. Provide task name and description
3. Claude creates git branch: `git checkout -b task/<username>-<number>-description`
4. Claude creates task file in this folder using the template from CLAUDE.md
5. Work on the task, updating the file regularly
6. When complete, task file is moved to `task/completed_task/` subfolder

See `CLAUDE.md` for complete workflow documentation.
