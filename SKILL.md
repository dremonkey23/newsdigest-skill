# NewsDigest

Pull and summarize top news stories by topic or keyword. Get a clean daily briefing without the noise.

## When to use this skill

- Morning briefings on any topic (AI, cybersecurity, crypto, business, politics)
- Tracking a specific keyword, company, or person in the news
- Competitive intelligence — what's happening in your industry today
- Research starting points — headlines with links before going deep

## How to use

Ask your agent:
- "NewsDigest: AI news today"
- "NewsDigest: cybersecurity breaches this week"
- "Give me a news digest on Solana"
- "What's happening with [topic]?"
- "NewsDigest: [company name]"

## What it does

1. Searches for top stories matching your topic or keyword using web search
2. Pulls headlines, sources, and publication dates
3. Summarizes each story in 1-2 plain-English sentences
4. Groups by theme if multiple stories overlap
5. Highlights any breaking or high-priority items
6. Delivers a clean digest with links to read more

## Output format

```
NEWSDIGEST: [Topic]
Date: [Today's date]
Stories found: [N]
==========================

1. [HEADLINE] — [Source] ([Date])
   Summary: [1-2 sentence plain-English summary]
   Link: [URL]

2. [HEADLINE] — [Source] ([Date])
   Summary: [1-2 sentence plain-English summary]
   Link: [URL]

...

KEY THEMES:
- [Theme 1]: [Brief description]
- [Theme 2]: [Brief description]

BREAKING / HIGH PRIORITY:
- [Any urgent items flagged here]
```

## Parameters

- **Topic/keyword** (required): what to search for
- **Count** (optional, default 5): how many stories to return (1-10)
- **Timeframe** (optional): "today", "this week", "this month" — defaults to today
- **Source filter** (optional): focus on a specific outlet if mentioned

## Scripts

The included scripts can be used to run a scheduled digest and output to a file:

- `run-digest.ps1` — Windows: pulls headlines via web search and formats output
- `run-digest.sh` — Linux/macOS: same via bash

## Use cases

- **Daily cron**: run every morning at 7am, save to a file, read it as part of your briefing
- **On-demand**: ask anytime for a quick topic briefing
- **Alerts**: pair with a heartbeat to flag breaking news on monitored topics

## Notes

- Uses web search — no API key required
- Best with specific topics (narrower = better summaries)
- For real-time breaking news, check primary sources via the provided links
