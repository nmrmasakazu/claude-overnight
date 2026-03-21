# claude-overnight

Run Claude Code autonomously overnight in a Docker container with a firewall.

Claude is given a task via a task file and runs against a target repository with `--dangerously-skip-permissions`, so it can freely read and write files without any confirmation prompts.

Network access is restricted by the official Anthropic firewall script, which only allows connections to Anthropic's API and a small set of trusted hosts (npm, GitHub, etc.).

## Prerequisites

- Docker & Docker Compose
- Claude Code installed and authenticated on the host (`claude`)

## Setup

Add `run.sh` to your PATH (optional, for convenience):

```sh
ln -s /path/to/claude-overnight/run.sh /usr/local/bin/claude-overnight
```

## Run

Navigate to the target repository, write a task file, and run:

```sh
cd /path/to/your/repository
echo "..." > TASK.md
claude-overnight            # uses TASK.md by default
claude-overnight mytask.md  # or specify a filename
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
