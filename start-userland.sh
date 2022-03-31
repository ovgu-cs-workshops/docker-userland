#!/bin/sh

dockerd-entrypoint.sh > /dev/null 2>&1 &
export USERSHELL=/usr/local/bin/run-shell.sh
/bin/git-userland
