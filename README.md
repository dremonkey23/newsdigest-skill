# 📰 NewsDigest

**Pull and summarize top news stories by topic or keyword. Daily briefings without the noise.**

Built for AI agents running on OpenClaw / LarryBrain. Ask your agent for a news digest on any topic and get clean, summarized headlines with links — in seconds.

---

## Quick Start

Ask your agent:
> "NewsDigest: AI news today"
> "NewsDigest: cybersecurity breaches this week"
> "What's happening with Solana?"

Or run the script directly:

```powershell
.\run-digest.ps1 -Topic "cybersecurity" -Count 5
.\run-digest.ps1 -Topic "AI news" -Count 10 -OutputFile "morning-brief.txt"
```

---

## Sample Output

```
NEWSDIGEST: AI news today
Date: Friday, February 21, 2026
Stories found: 5
==========================

1. OpenAI Releases New Model Beating All Benchmarks
   Source: TechCrunch | Feb 21, 9:00 AM
   Summary: OpenAI announced a new flagship model today that surpasses GPT-4
   on all standard benchmarks, with particular gains in coding and reasoning.
   Link: https://techcrunch.com/...

2. Google DeepMind Partners With NHS for Medical AI
   Source: Reuters | Feb 21, 7:30 AM
   Summary: DeepMind and the NHS signed a 5-year agreement to deploy AI
   diagnostics tools across 50 hospitals in the UK starting Q3 2026.
   Link: https://reuters.com/...

KEY THEMES:
- Model competition heating up between major AI labs
- Healthcare AI deployment accelerating in Europe
```

---

## Features

- No API key required — uses public news feeds
- Works on any topic, keyword, company, or person
- Timeframe filtering: today, this week, this month
- Save output to file for scheduled morning briefings
- Pair with OpenClaw cron for automatic daily digests

---

## Schedule a Daily Digest

Set up a morning briefing in your OpenClaw heartbeat or cron:

```
Every morning at 7am: Run NewsDigest on "cybersecurity news" and send me the summary
```

---

Built by [@drizzy8423](https://x.com/sheeptweetZ) | Powered by [LarryBrain](https://larrybrain.com)
