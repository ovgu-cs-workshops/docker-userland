#!/bin/sh

dockerd-entrypoint.sh > /dev/null 2>&1 &
export DOCKER_HOST="unix:///run/user/1000/docker.sock"
/bin/git-userland
