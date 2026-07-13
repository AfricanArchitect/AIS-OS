# Connections

Registry of every system Chanel's AIOS reaches. All seven domains are LIVE via Supabase project `trgrrvewlqrtfzghmkis` (Chanel-owned), visualized at founder.yoursia.com. Secrets live server-side in `app_secrets` — never in this repo.

| # | Domain | Tool | Mechanism | Auth | Last checked |
|---|---|---|---|---|---|
| 1 | Revenue / Financials | Stripe (+ Connect 90/10) | edge fn `pull-stripe`, cron 6h → `stripe_snapshot` | restricted key in app_secrets | 2026-06-15 |
| 2 | Customer interactions | GoHighLevel (hRg3Q5MVSG6viOletlMo) | edge fns `pull-ghl-snapshot` + `pull-ghl-social`, cron 4h | PIT token in app_secrets | 2026-06-15 |
| 3 | Calendar | M365 Outlook (chanel@chanelmarie.com) | edge fn `pull-m365`, cron 1h → `calendar_events` | Azure app-only (Graph) | 2026-06-15 |
| 4 | Communication | M365 Mail + Teams (Gmail/Proton forward in) | `pull-m365` → `inbox_items` | Azure app-only (Graph) | 2026-06-15 |
| 5 | Project / task tracking | Notion (Blueprint Architect's Space) | edge fns `pull-notion` + `pull-notion-rich`, cron 6h → `projects`, `tasks` | integration token in app_secrets | 2026-06-15 |
| 6 | Meeting intelligence | Notion Comm Log + EPAI Meetings; Plaud voice | `pull-notion-rich` → `meetings`; `intake-voice` webhook | token / X-Intake-Secret | 2026-06-15 |
| 7 | Knowledge / files | Notion (Research Library, EPAI Vault, Handbook) + OneDrive/SharePoint | `pull-notion-rich` → `knowledge_index` (Postgres FTS) | token / Graph | 2026-06-15 |

Also live: YouTube Data API (`pull-youtube`, 6h → social_metrics), Anthropic direct (all chiefs + briefs + CRIT), 8 automation scenarios (morning brief 7am CT, EOD 6pm CT, calendar rules 2h, Notion-ready publish 15m, Stripe webhook, GHL stage webhook, AICT lead form, Plaud voice intake), scorecard refresh daily.

**Mechanism notes:** the app repo is `AfricanArchitect/Founder-AIOS` (deploys to founder.yoursia.com). This repo (AIS-OS) is the brain on Chanel's Mac; the app is the visualization + agent-profile layer. When you wire a new tool, add a row here AND a `references/{tool}-api.md`.
