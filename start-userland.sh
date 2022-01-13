#!/bin/sh

dockerd-entrypoint.sh > /dev/null 2>&1 &
/bin/zsh
