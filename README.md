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

目前支援 `/home/benny`、`/mnt/c/Users/benny`、`/mnt/c/Users/045650`。不存在的目標會明確顯示為 skipped。

目標檔尾端若有 `codebase-memory-mcp` 自動注入區塊，會原樣保留。
