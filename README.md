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

## Stop

Press `Ctrl+C` to stop the running container, or from another terminal:

```sh
docker compose -f /path/to/claude-overnight/docker-compose.yml down
```

## Custom Allowed Domains

To allow additional domains beyond the defaults, set `EXTRA_ALLOWED_DOMAINS` (comma-separated):

```sh
EXTRA_ALLOWED_DOMAINS="pypi.org,files.pythonhosted.org" claude-overnight
```

## Shell Access

To open a shell in the running container:

```sh
docker exec -it claude-overnight bash
claude --dangerously-skip-permissions

/login
@/TASK.md
```
