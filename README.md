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

`AGENTS.gpt.md` 是給 GPT 模型（Codex 與 ChatGPT）共用的補充，同步時接在 `AGENTS.md` 內容後面，其他目標不含這段。`AGENTS.chatgpt.md` 是只給 ChatGPT 的補充。

ChatGPT 沒有可同步的檔案入口，腳本會另外產出 `dist/chatgpt.md`（`AGENTS.md` → `AGENTS.gpt.md` → `AGENTS.chatgpt.md`），手動貼到 ChatGPT 的自訂指令或 Project 指示。檔案第一行是版本（commit 日期與 hash），ChatGPT 裡貼的版本和這行不同就代表過期了。

目前支援 `/home/benny`、`/mnt/c/Users/benny`、`/c/Users/benny`（Git Bash）、`/mnt/c/Users/045650`、`/c/Users/045650`（Git Bash）。不存在的目標會明確顯示為 skipped。

## 與 CC Switch 的分工

CC Switch 管 provider、Claude／Codex 的通用設定與 MCP；切換 provider 時，它會用「provider 存檔＋通用設定」整份覆寫 `~/.claude/settings.json` 與 `~/.codex/config.toml`，所以這兩個檔案的長期修改要改在 CC Switch，不直接改檔。全域指示只由本 repo 的 `sync.sh` 寫入：CC Switch 的「提示詞」功能保持停用（只存一份目前內容的副本），不在那裡編輯或啟用，否則會用舊內容蓋掉同步產物。Skills 由 `~/skills` repo 加連結管理，不用 CC Switch 安裝。

`.claude/CLAUDE.md` 是 Claude Code 唯一的使用者層級入口：Claude Code 的 `AGENTS.md` 支援只在專案層級生效（專案沒有 `CLAUDE.md` 時讀取），不會讀 `~/.claude/AGENTS.md`。這個檔案只是同步產物，不要直接編輯。
