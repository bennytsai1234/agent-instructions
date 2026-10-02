#!/usr/bin/env bash
# Sync the canonical AGENTS.md into the global instruction entrypoints that exist on this machine.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOMES=(
  "/home/benny"
  "/mnt/c/Users/benny"
  "/c/Users/benny"
  "/mnt/c/Users/045650"
  "/c/Users/045650"
)

# Usage: sync_one <target> [extra source appended after AGENTS.md]
sync_one() {
  local target="$1"
  local extra="${2:-}"
  local dir
  dir="$(dirname "$target")"

  if [ ! -d "$dir" ]; then
    echo "  skipped $target (directory missing)"
    return 0
  fi

  cat "$SRC/AGENTS.md" ${extra:+"$SRC/$extra"} > "$target.tmp"
  mv "$target.tmp" "$target"
  echo "  synced $target"
}

found_home=0
for h in "${HOMES[@]}"; do
  [ -d "$h" ] || continue
  found_home=1
  echo "$h"
  sync_one "$h/.codex/AGENTS.md" AGENTS.codex.md
  sync_one "$h/.claude/CLAUDE.md"
  sync_one "$h/.config/opencode/AGENTS.md"
  sync_one "$h/.gemini/antigravity-cli/AGENTS.md"
  sync_one "$h/.gemini/GEMINI.md"
done

if [ "$found_home" -eq 0 ]; then
  echo "No supported home directory found."
fi
