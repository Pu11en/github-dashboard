#!/bin/bash
# Find repos matching Drew's interests: AI agents, automation, SaaS

OUTPUT_FILE="/home/drewp/clawd/github-dashboard/data/steal-this.json"

QUERIES=(
  "ai agent framework"
  "automation bot"
  "saas boilerplate nextjs"
  "telegram bot typescript"
  "claude api"
  "llm tools"
)

echo "[" > "$OUTPUT_FILE"
first=true

for query in "${QUERIES[@]}"; do
  if [ "$first" = false ]; then echo "," >> "$OUTPUT_FILE"; fi
  first=false
  
  gh api search/repositories \
    -X GET \
    -f q="$query stars:>50" \
    -f sort=stars \
    -f per_page=5 \
    --jq '.items | map({
      name: .full_name,
      description: .description,
      stars: .stargazers_count,
      url: .html_url,
      query: "'"$query"'"
    })' >> "$OUTPUT_FILE"
done

echo "]" >> "$OUTPUT_FILE"
echo "Saved steal-this repos"
