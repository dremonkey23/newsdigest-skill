# NewsDigest - Pull and summarize top news by topic or keyword
# Usage: .\run-digest.ps1 [-Topic "AI"] [-Count 5] [-OutputFile "digest.txt"]
# Omit -Topic to get a full daily digest across all categories
# Author: @drizzy8423

param(
    [string]$Topic = "",
    [int]$Count = 5,
    [string]$Timeframe = "today",
    [string]$OutputFile = ""
)

$ErrorActionPreference = "Continue"
$timestamp = Get-Date -Format "dddd, MMMM dd, yyyy h:mm tt"

# Default topics when none specified - covers everything
if ($Topic) {
    $searchTopics = @($Topic)
} else {
    $searchTopics = @(
        "top news today",
        "technology AI",
        "business finance markets",
        "cybersecurity",
        "politics",
        "crypto bitcoin",
        "sports highlights",
        "science health"
    )
}

Write-Host ""
Write-Host "============================================"
Write-Host "  NEWSDIGEST -- Daily Briefing"
Write-Host "  $timestamp"
Write-Host "============================================"
Write-Host ""

$allOutput = [System.Collections.Generic.List[string]]::new()
$totalStories = 0
$storiesPerTopic = [Math]::Max(1, [Math]::Ceiling($Count / $searchTopics.Count))

foreach ($searchTopic in $searchTopics) {
    $query = $searchTopic + " " + $Timeframe
    $searchEncoded = [System.Uri]::EscapeDataString($query)
    $amp = [char]38
    $feedUrl = "https://news.google.com/rss/search?q=" + $searchEncoded + $amp + "hl=en-US" + $amp + "gl=US" + $amp + "ceid=US:en"

    Write-Host ("--- " + $searchTopic.ToUpper() + " ---")
    $allOutput.Add("--- " + $searchTopic.ToUpper() + " ---")

    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("User-Agent", "Mozilla/5.0")
        [xml]$feed = $wc.DownloadString($feedUrl)
        $items = $feed.rss.channel.item | Select-Object -First $storiesPerTopic

        foreach ($item in $items) {
            $title  = ($item.title -replace '<[^>]+>','').Trim()
            $source = if ($item.source.'#text') { $item.source.'#text' } else { "News" }
            $link   = $item.link

            $pubDate = ""
            try {
                $parsedDate = [DateTime]::Parse($item.pubDate)
                $pubDate = $parsedDate.ToString("MMM dd, h:mm tt")
            } catch { }

            Write-Host ("  * " + $title)
            Write-Host ("    " + $source + "  " + $pubDate)
            Write-Host ("    " + $link)
            Write-Host ""

            $allOutput.Add("  * " + $title)
            $allOutput.Add("    " + $source + "  " + $pubDate)
            $allOutput.Add("    " + $link)
            $allOutput.Add("")
            $totalStories++
        }
    } catch {
        $errMsg = "  [Could not fetch: " + $_.Exception.Message + "]"
        Write-Host $errMsg
        $allOutput.Add($errMsg)
    }

    Start-Sleep -Milliseconds 400
}

Write-Host "============================================"
Write-Host ("  Total stories: " + $totalStories)
Write-Host ("  Generated: " + $timestamp)
Write-Host "============================================"
Write-Host "Powered by NewsDigest | github.com/dremonkey23/newsdigest-skill"

if ($OutputFile) {
    Set-Content -Path $OutputFile -Value ($allOutput -join [System.Environment]::NewLine) -Encoding UTF8
    Write-Host ("Saved to: " + $OutputFile)
}
