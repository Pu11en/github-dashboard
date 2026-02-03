#!/bin/bash
# Fetch trending repos from GitHub

OUTPUT_FILE="/home/drewp/clawd/github-dashboard/data/trending.json"

# Get trending repos via GitHub search API (sorted by stars, created recently)
gh api search/repositories \
  -X GET \
  -f q='stars:>100 pushed:>2026-01-01 language:typescript OR language:python' \
  -f sort=stars \
  -f order=desc \
  -f per_page=30 \
  --jq '.items | map({
    name: .full_name,
    description: .description,
    stars: .stargazers_count,
    url: .html_url,
    language: .language,
    topics: .topics
  })' > "$OUTPUT_FILE"

echo "Saved $(cat $OUTPUT_FILE | jq length) trending repos to $OUTPUT_FILE"
