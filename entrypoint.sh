#!/usr/bin/env bash
set -euo pipefail

sudo /usr/local/bin/init-firewall.sh
sudo -E /usr/local/bin/add-custom-domains.sh

[[ ! -f /TASK.md ]] && { echo "ERROR: TASK.md not found." >&2; exit 1; }
TASK=$(cat /TASK.md)
[[ -z "${TASK// }" ]] && { echo "ERROR: TASK.md is empty." >&2; exit 1; }

[[ -z "$(ls -A /home/node/.claude 2>/dev/null)" ]] && {
    echo "ERROR: Not logged in. Run 'claude' on host first." >&2; exit 1; }

[[ ! -d /target ]] && { echo "ERROR: REPO_PATH not mounted." >&2; exit 1; }

echo "=== Starting - $(date '+%Y-%m-%d %H:%M:%S') ==="

# Keep container running after task completes
tail -f /dev/null
