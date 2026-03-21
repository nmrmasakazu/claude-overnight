#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

TASK_FILE="$(pwd)/${1:-TASK.md}"
if [[ ! -f "$TASK_FILE" ]]; then
    echo "ERROR: $(basename "$TASK_FILE") not found in current directory." >&2
    exit 1
fi

export REPO_PATH="$(pwd)"
export TASK_FILE

docker compose -f "$SCRIPT_DIR/docker-compose.yml" up --build
