#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$ROOT_DIR/scripts/install.sh"

echo
echo "Press Return to close this window."
read -r _ || true
