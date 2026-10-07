
## 5. 環境
- **公司網路**：`registry.npmjs.org` 被 McAfee 政策封鎖（npm 報 SSL 錯誤），npm／npx 改走內部 Verdaccio `https://ctverdaccio.cotabank.com/`，不繞過封鎖、不關 TLS；GitHub 的 `git clone` 正常；session 內跑 `claude plugins …` 會卡到逾時，外掛狀態改讀 `~/.claude/plugins/` 與 `~/.claude/settings.json`。
