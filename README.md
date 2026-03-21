# claude-overnight

Run Claude Code autonomously overnight in a Docker container with a firewall.

Claude is given a task via `TASK.md` and runs against a target repository with `--dangerously-skip-permissions`, so it can freely read and write files without any confirmation prompts.

Network access is restricted by the official Anthropic firewall script, which only allows connections to Anthropic's API and a small set of trusted hosts (npm, GitHub, etc.).

## Prerequisites

- Docker & Docker Compose
- Claude Code installed and authenticated on the host (`claude`)

## Setup

1. Set the target repository path:
   ```sh
   export REPO_PATH=/path/to/your/repository
   ```
2. Write your task in `TASK.md`:
   ```sh
   echo "..." > TASK.md
   ```

## Run

```sh
docker compose up --build
```

Logs are saved to `claude.log` in the target repository.

## Stop

```sh
docker compose down
```

## Shell Access

To open a shell in the running container:

```sh
docker exec -it claude-overnight bash
```
