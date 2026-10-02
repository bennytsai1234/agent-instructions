# Agent Instructions

給 Codex、Claude、OpenCode、Gemini 等 coding agent 使用的共用全域指示。

`AGENTS.md` 是唯一的 canonical source。這個 repository 只維護跨專案都成立的工作法則；主機資訊、公司平台規則、專案架構與特定工作流改用專案文件或 Skills 按需載入。

## 同步

只需要執行一支腳本：

```bash
./sync.sh
```

腳本會偵測目前機器上存在的 home，將 `AGENTS.md` 同步到：

- `.codex/AGENTS.md`
- `.claude/CLAUDE.md`
- `.config/opencode/AGENTS.md`
- `.gemini/antigravity-cli/AGENTS.md`
- `.gemini/GEMINI.md`

`AGENTS.codex.md` 是只給 Codex（GPT-6.1 Sol）的補充，同步時接在 `.codex/AGENTS.md` 的 `AGENTS.md` 內容後面，其他目標不含這段。

目前支援 `/home/benny`、`/mnt/c/Users/benny`、`/c/Users/benny`（Git Bash）、`/mnt/c/Users/045650`、`/c/Users/045650`（Git Bash）。不存在的目標會明確顯示為 skipped。

`.claude/CLAUDE.md` 是 Claude Code 唯一的使用者層級入口：Claude Code 的 `AGENTS.md` 支援只在專案層級生效（專案沒有 `CLAUDE.md` 時讀取），不會讀 `~/.claude/AGENTS.md`。這個檔案只是同步產物，不要直接編輯。
