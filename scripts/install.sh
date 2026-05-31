#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PACKAGE_DIR="$REPO_ROOT/package"

PET_JSON="$PACKAGE_DIR/pet.json"
SPRITESHEET="$PACKAGE_DIR/spritesheet.webp"

if [[ ! -f "$PET_JSON" ]]; then
  echo "pet.json not found: $PET_JSON" >&2
  exit 1
fi

if [[ ! -f "$SPRITESHEET" ]]; then
  echo "spritesheet.webp not found: $SPRITESHEET" >&2
  exit 1
fi

CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="$CODEX_ROOT/pets/pink-signal"

mkdir -p "$TARGET_DIR"
cp "$PET_JSON" "$TARGET_DIR/pet.json"
cp "$SPRITESHEET" "$TARGET_DIR/spritesheet.webp"

echo "Installed Pink Signal to: $TARGET_DIR"
echo "Restart Codex if the pet list does not refresh immediately."
