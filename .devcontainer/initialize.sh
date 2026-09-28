#!/usr/bin/env bash

# Grant local container connections access to the X server
xhost +si:localuser:$(id -un) > /dev/null 2>&1

cat << EOF > .devcontainer/.env
USER=$(id -un)
USER_UID=$(id -u)
USER_GID=$(id -g)
WORKSPACE_PATH=$(pwd)
WORKSPACE_NAME=$(basename $(pwd))
EOF
