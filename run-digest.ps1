# NewsDigest - Pull and summarize top news stories by topic or keyword
# Usage: .\run-digest.ps1 -Topic "AI news" [-Count 5] [-OutputFile "digest.txt"]
# Author: @drizzy8423

param(
    [Parameter(Mandatory=$true)]
    [string]$Topic,
    [int]$Count = 5,
    [string]$Timeframe = "today",
    [string]$OutputFile = ""
)

$ErrorActionPreference = "Continue"
$date = Get-Date -Format "yyyy-MM-dd"
$timestamp = Get-Date -Format "dddd, MMMM dd, yyyy h:mm tt"

$header = @"

==========================
  NEWSDIGEST: $Topic
  Date: $timestamp
  Timeframe: $Timeframe
==========================

"@

Write-Host $header

# Build search query with timeframe
$query = $Topic
switch ($Timeframe.ToLower()) {
    "today"      { $query = "$Topic news today" }
    "this week"  { $query = "$Topic news this week" }
    "this month" { $query = "$Topic news this month" }
    default      { $query = "$Topic news today" }
}

Write-Host "Searching: $query"
Write-Host "Fetching top $Count stories..."
Write-Host ""

# Fetch from Brave Search RSS / public news feeds
$results = @()

# Try multiple free RSS sources
$feedUrls = @(
    "https://feeds.feedburner.com/TechCrunch",
    "https://rss.cnn.com/rss/edition.rss",
    "https://feeds.reuters.com/reuters/topNews",
    "https://feeds.bbci.co.uk/news/rss.xml"
)

$searchEncoded = [System.Uri]::EscapeDataString($query)

# Use Brave Search RSS if available, fall back to Google News
$googleNewsUrl = "https://news.google.com/rss/search?q=$searchEncoded&hl=en-US&gl=US&ceid=US:en"

try {
    [xml]$feed = (New-Object System.Net.WebClient).DownloadString($googleNewsUrl)
    $items = $feed.rss.channel.item | Select-Object -First $Count

    $storyNum = 0
    foreach ($item in $items) {
        $storyNum++
        $title   = $item.title  -replace '<[^>]+>',''
        $source  = if ($item.source.'#text') { $item.source.'#text' } else { "Google News" }
        $link    = $item.link
        $pubDate = $item.pubDate

        # Clean up date
        try {
            $parsedDate = [DateTime]::Parse($pubDate)
            $pubDate = $parsedDate.ToString("MMM dd, h:mm tt")
        } catch { }

        $storyText = @"
$storyNum. $title
   Source: $source | $pubDate
   Link: $link

"@
        Write-Host $storyText
        $results += $storyText
    }

    Write-Host "=========================="
    Write-Host "  Stories pulled: $storyNum"
    Write-Host "  Topic: $Topic"
    Write-Host "  Run this digest through your AI agent for summaries and key themes."
    Write-Host "=========================="
    Write-Host ""

} catch {
    Write-Host "Could not fetch news feed. Error: $_"
    Write-Host ""
    Write-Host "Tip: Run this query in your AI agent for a manual digest:"
    Write-Host "  'Search for top news stories about $Topic today and summarize them'"
    exit 1
}

# Save to file if requested
if ($OutputFile) {
    $fullOutput = $header + ($results -join "") + "`n[Digest generated: $timestamp]"
    Set-Content -Path $OutputFile -Value $fullOutput -Encoding UTF8
    Write-Host "Saved to: $OutputFile"
}

Write-Host "Powered by NewsDigest | github.com/dremonkey23/newsdigest-skill"
