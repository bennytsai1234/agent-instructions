
---

## 六 · 委派 Codex

**不要把 worktree 和背景執行混用。** Agent 的 `isolation:"worktree"` 配上 `run_in_background`（或 companion `--background`），harness 會把臨時 worktree 清掉，Codex 卡在那裡跑不完也沒有產出。這是 codex-plugin-cc 已知的 open bug。

需要背景時，自己用 `git worktree add` 建一個持久的 worktree，前景跑完、驗收過再移除。Windows 上 worktree 裡的 Codex 一律前景。

**模型和推理程度分開指定：**`--model <id> --effort <level>`，或在 config.toml 設 `model` / `model_reasoning_effort`。

模型要用完整 id：`gpt-5.6-luna`、`gpt-5.6-sol`、`gpt-5.5`（裸 `luna` 不支援）。合法的 effort：`low` / `medium` / `high` / `xhigh` / `ultra` / `max`。實質 coding 預設 `--model gpt-5.6-luna`。
