# Agnostic Dev Container Template

A minimal, robust `.devcontainer` skeleton optimized for Linux.

## Features

* **GUI:** Native X11 and Wayland forwarding.
* **NVIDIA:** Host GPU and CUDA access.
* **Permissions:** Automatic host UID/GID mirroring to prevent volume permission conflicts.
* **SSH:** Host SSH agent forwarding for secure Git operations.
* **IPC/Network:** Host network mode, host IPC, and privileged mode for hardware device access (`/dev`).

## Setup

1. Copy the `.devcontainer` folder into your project root.
2. Open the project directory in VS Code or Cursor.
3. Run the command palette (`Ctrl+Shift+P`) and select `Dev Containers: Rebuild and Reopen in Container`.
