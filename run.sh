#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

ARG="${1:-TASK.md}"
if [[ "$ARG" = /* ]]; then
    TASK_FILE="$ARG"
else
    TASK_FILE="$(pwd)/$ARG"
fi
if [[ ! -f "$TASK_FILE" ]]; then
    echo "ERROR: $TASK_FILE not found." >&2
    exit 1
fi

export REPO_PATH="$(pwd)"
export TASK_FILE

docker compose -f "$SCRIPT_DIR/docker-compose.yml" up --build
