# Inscription Engine v1.1
$date = Get-Date -Format "yyyy-MM-dd"
$title = Read-Host "Title of this Inscription"
$slug = $title.ToLower().Replace(" ", "-").Replace("'", "")
$fileName = "$date-$slug.mdx"

Write-Host "--- Classification ---" -ForegroundColor Cyan
$type = Read-Host "Type (Zero-Shot, Chain of Thought, etc.)"
$status = Read-Host "Status (Ideation, Validated, etc.)"
$tags = Read-Host "Tags (comma separated)"

Write-Host "--- Narrative Context ---" -ForegroundColor Cyan
$goal = Read-Host "The Goal (What do we want to achieve?)"
$context = Read-Host "Context (What were we doing?)"

# Building the template with careful quote handling for tags
$tagArray = $tags -split ',' | ForEach-Object { '"' + $_.Trim() + '"' }
$tagString = $tagArray -join ", "

$template = @"
---
title: "$title"
date: "$date"
author: "zz"
type: "$type"
status: "$status"
tags: [$tagString]
repoUrl: "https://github.com/BirSurgun/zzLearns-governance"
---

# The Goal
$goal

# The Prompt
``text
[Paste the prompt here]
``

# Context & Outcome
**Context:** $context

**Outcome:** [Did we achieve the desired outcome?]
"@

# Save with UTF8 encoding to ensure it works across all your machines
$template | Out-File -FilePath "./$fileName" -Encoding utf8

Write-Host ""
Write-Host "[OK] Inscription created: $fileName" -ForegroundColor Green