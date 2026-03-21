#!/usr/bin/env bash
set -euo pipefail

sudo /usr/local/bin/init-firewall.sh

[[ ! -f /TASK.md ]] && { echo "ERROR: TASK.md not found." >&2; exit 1; }
TASK=$(cat /TASK.md)
[[ -z "${TASK// }" ]] && { echo "ERROR: TASK.md is empty." >&2; exit 1; }

[[ -z "$(ls -A /home/node/.claude 2>/dev/null)" ]] && {
    echo "ERROR: Not logged in. Run 'claude' on host first." >&2; exit 1; }

[[ ! -d /target ]] && { echo "ERROR: REPO_PATH not mounted." >&2; exit 1; }

echo "=== Claude starting - $(date '+%Y-%m-%d %H:%M:%S') ==="
cd /target
claude --dangerously-skip-permissions --print "$TASK" 2>&1 | tee claude.log
echo "=== Claude done - $(date '+%Y-%m-%d %H:%M:%S') ==="
