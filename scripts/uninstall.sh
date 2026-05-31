#!/usr/bin/env bash
set -euo pipefail

CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_ROOT/pets/pink-signal"

if [[ -d "$TARGET_DIR" ]]; then
  rm -rf "$TARGET_DIR"
  echo "Removed Pink Signal from: $TARGET_DIR"
else
  echo "Pink Signal is not installed at: $TARGET_DIR"
fi
