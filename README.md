# 全域使用者指示

給 AI coding agent 讀的全域指示檔。核心保留跨任務都會改變行為的規則，工具與領域細節由附錄或技能按需提供。

## 內容

| 檔案 | 用途 |
|---|---|
| `core.md` | 共用核心，四個工具都一樣 |
| `appendix-codex.md` | Codex 專屬（子代理併發） |

## 同步位置

Windows 家目錄 `C:\Users\benny\` 與 WSL 家目錄 `/home/benny/` 各一份。

| 位置 | 組成 |
|---|---|
| `.codex/AGENTS.md` | core + appendix-codex |
| `.claude/CLAUDE.md` | core |
| `.config/opencode/AGENTS.md` | core |
| `.gemini/antigravity-cli/AGENTS.md` | core |
| `.gemini/GEMINI.md` | core |

各檔案尾端由 codebase-memory-mcp 自動注入的區塊（`<!-- codebase-memory-mcp:start -->` 到 `:end`）原樣保留，同步時不覆蓋。

## 同步

```bash
./sync.sh
```
