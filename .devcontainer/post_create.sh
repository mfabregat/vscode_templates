#!/usr/bin/env bash

# --- Commit-time formatting hooks -------------------------------------------
# Shared pre-commit hooks (ruff for Python, clang-format for C++) so every
# committed file is formatted/linted, including files written by an agent that
# were never opened in the editor. The configs live in the workspace (which is
# bind-mounted, so they persist); only the tool and the global core.hooksPath
# need to be applied inside the container.
#   See .pre-commit-config.yaml and .githooks/pre-commit
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v pre-commit >/dev/null 2>&1 && [ ! -x "${HOME}/.local/bin/pre-commit" ]; then
  python3 -m pip install --user --upgrade pre-commit
fi

# `pip install --user` installs the console script into ~/.local/bin, which is
# not on the default PATH of this image.
export PATH="${HOME}/.local/bin:${PATH}"
grep -q 'HOME/.local/bin' "${HOME}/.bashrc" || \
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${HOME}/.bashrc"

chmod +x "${WORKSPACE_DIR}/.githooks/pre-commit" 2>/dev/null || true
git config --global core.hooksPath "${WORKSPACE_DIR}/.githooks"
# ----------------------------------------------------------------------------

sudo apt-get update && sudo apt-get upgrade -y
rosdep update
rosdep install --from-paths src --ignore-src -r -y

colcon build --symlink-install --cmake-args '-DCMAKE_BUILD_TYPE=RelWithDebInfo' '-DCMAKE_EXPORT_COMPILE_COMMANDS=On' -Wall -Wextra -Wpedantic
