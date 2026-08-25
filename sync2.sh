#!/usr/bin/env bash
# 本機專屬同步。把 core.md（加上工具專屬附錄）同步到各全域指示檔。
# 只寫 Windows 家目錄 045650；WSL 家目錄的 .codex/AGENTS.md 與 .claude/CLAUDE.md
# 已是指向這裡的 symlink，會自動讀到同一份。
# 目標檔尾端由 codebase-memory-mcp 注入的區塊會原樣保留。
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOMES=("/mnt/c/Users/045650")

sync_one() {
  local target="$1"; shift
  local dir
  dir="$(dirname "$target")"
  [ -d "$dir" ] || return 0

  local mcp=""
  if [ -f "$target" ]; then
    mcp="$(sed -n '/<!-- codebase-memory-mcp:start -->/,/<!-- codebase-memory-mcp:end -->/p' "$target")"
  fi

  cat "$@" > "$target.tmp"
  if [ -n "$mcp" ]; then
    printf '\n' >> "$target.tmp"
    printf '%s\n' "$mcp" >> "$target.tmp"
  fi
  mv "$target.tmp" "$target"
  echo "  $target"
}

for h in "${HOMES[@]}"; do
  [ -d "$h" ] || continue
  echo "$h"
  sync_one "$h/.codex/AGENTS.md"                  "$SRC/core.md" "$SRC/appendix-codex.md"
  sync_one "$h/.claude/CLAUDE.md"                 "$SRC/core.md"
  sync_one "$h/.config/opencode/AGENTS.md"        "$SRC/core.md"
  sync_one "$h/.gemini/antigravity-cli/AGENTS.md" "$SRC/core.md"
  sync_one "$h/.gemini/GEMINI.md"                 "$SRC/core.md"
done
