#!/bin/bash
# Sync trending repos to Notion - uses ~/.notion_key or NOTION_API_KEY env

NOTION_KEY="${NOTION_API_KEY:-$(cat ~/.notion_key 2>/dev/null)}"
DB_ID="a6c75366-240e-41a3-972d-be609d36c604"

[ -z "$NOTION_KEY" ] && { echo "Set NOTION_API_KEY or create ~/.notion_key"; exit 1; }

echo "🔄 Syncing to Notion..."

gh api search/repositories -f q='stars:>500 created:>2025-12-01 (AI OR agent OR automation)' -f sort=stars -f per_page=10 --jq '.items[]' | while read -r line; do
    NAME=$(echo "$line" | jq -r '.full_name')
    STARS=$(echo "$line" | jq -r '.stargazers_count') 
    URL=$(echo "$line" | jq -r '.html_url')
    curl -s -X POST "https://api.notion.com/v1/pages" \
      -H "Authorization: Bearer $NOTION_KEY" \
      -H "Notion-Version: 2025-09-03" \
      -H "Content-Type: application/json" \
      -d '{"parent":{"database_id":"'$DB_ID'"},"properties":{"Repo":{"title":[{"text":{"content":"'$NAME'"}}]},"Stars":{"number":'$STARS'},"URL":{"url":"'$URL'"},"Status":{"select":{"name":"New"}}}}' > /dev/null && echo "✅ $NAME"
done
