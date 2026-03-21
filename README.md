# claude-overnight

Run Claude Code autonomously overnight in a Docker container with a firewall.

## Prerequisites

- Docker & Docker Compose
- Claude Code installed and logged in on the host (`claude`)

## Setup

1. Set the target repository path:
   ```sh
   export REPO_PATH=/path/to/your/repository
   ```
2. Write your task in `TASK.md`

## Run

```sh
docker compose up --build
```

Logs are saved to `claude.log` in the target repository.

## Shell Access

To open a shell in the running container:

```sh
docker exec -it claude-overnight bash
```
