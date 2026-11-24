#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "Set DOCKER_USER and DOCKER_PWD environment variables"
  exit 1
fi

set -e
export GIT_TERMINAL_PROMPT=0

# accept "user/repo" or a full URL, with or without .git at the end
GITHUB_REPO="${1#https://github.com/}"
GITHUB_REPO="${GITHUB_REPO%.git}"
DOCKER_REPO="$2"
WORKDIR=$(mktemp -d)

trap 'rm -rf "$WORKDIR"' EXIT

echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

git clone "https://github.com/$GITHUB_REPO" "$WORKDIR"
docker build -t "$DOCKER_REPO" "$WORKDIR"
docker push "$DOCKER_REPO"