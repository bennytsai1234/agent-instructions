#!/usr/bin/env bash
# Sync the canonical AGENTS.md into the global instruction entrypoints that exist on this machine.
# Preserve the codebase-memory-mcp block already injected at the end of a target file.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOMES=(
  "/home/benny"
  "/mnt/c/Users/benny"
  "/mnt/c/Users/045650"
)

sync_one() {
  local target="$1"
  local dir
  dir="$(dirname "$target")"

  if [ ! -d "$dir" ]; then
    echo "  skipped $target (directory missing)"
    return 0
  fi

  local mcp=""
  if [ -f "$target" ]; then
    mcp="$(sed -n '/<!-- codebase-memory-mcp:start -->/,/<!-- codebase-memory-mcp:end -->/p' "$target")"
  fi

  cat "$SRC/AGENTS.md" > "$target.tmp"
  if [ -n "$mcp" ]; then
    printf '\n' >> "$target.tmp"
    printf '%s\n' "$mcp" >> "$target.tmp"
  fi
  mv "$target.tmp" "$target"
  echo "  synced $target"
}

found_home=0
for h in "${HOMES[@]}"; do
  [ -d "$h" ] || continue
  found_home=1
  echo "$h"
  sync_one "$h/.codex/AGENTS.md"
  sync_one "$h/.claude/CLAUDE.md"
  sync_one "$h/.config/opencode/AGENTS.md"
  sync_one "$h/.gemini/antigravity-cli/AGENTS.md"
  sync_one "$h/.gemini/GEMINI.md"
done

if [ "$found_home" -eq 0 ]; then
  echo "No supported home directory found."
fi
