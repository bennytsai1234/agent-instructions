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

# Usage: sync_one <target> [extra sources appended after AGENTS.md, in order]
sync_one() {
  local target="$1"
  shift
  local dir
  dir="$(dirname "$target")"

  if [ ! -d "$dir" ]; then
    echo "  skipped $target (directory missing)"
    return 0
  fi

  (cd "$SRC" && cat AGENTS.md "$@") > "$target.tmp"
  mv "$target.tmp" "$target"
  echo "  synced $target"
}

found_home=0
for h in "${HOMES[@]}"; do
  [ -d "$h" ] || continue
  found_home=1
  echo "$h"
  extras=()
  if [ "${h##*/}" = "045650" ]; then
    extras+=(company.md)
  fi
  sync_one "$h/.codex/AGENTS.md" "${extras[@]}" AGENTS.gpt.md
  sync_one "$h/.claude/CLAUDE.md" "${extras[@]}"
  sync_one "$h/.config/opencode/AGENTS.md" "${extras[@]}"
  sync_one "$h/.gemini/antigravity-cli/AGENTS.md" "${extras[@]}"
  sync_one "$h/.gemini/GEMINI.md" "${extras[@]}"
done

if [ "$found_home" -eq 0 ]; then
  echo "No supported home directory found."
fi

# ChatGPT has no file entrypoint and is updated by manual paste, so stamp the build with the
# commit it came from; comparing stamps is how a stale paste gets noticed.
chatgpt_sources=(AGENTS.md)
if [ "${HOME##*/}" = "045650" ]; then
  chatgpt_sources+=(company.md)
fi
chatgpt_sources+=(AGENTS.gpt.md AGENTS.chatgpt.md)
version="$(git -C "$SRC" log -1 --format='%cd · %h' --date=short)"
if [ -n "$(git -C "$SRC" status --porcelain -- "${chatgpt_sources[@]}")" ]; then
  version="$version（含未提交修改）"
fi
mkdir -p "$SRC/dist"
{ printf '版本：%s\n\n' "$version"; (cd "$SRC" && cat "${chatgpt_sources[@]}"); } > "$SRC/dist/chatgpt.md"
echo "built $SRC/dist/chatgpt.md"
