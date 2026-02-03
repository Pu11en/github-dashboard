#!/bin/bash
# Search for useful code patterns
# Usage: ./snippets.sh "search query"

QUERY="$1"
if [ -z "$QUERY" ]; then
  echo "Usage: ./snippets.sh 'code pattern'"
  exit 1
fi

gh api search/code \
  -X GET \
  -f q="$QUERY language:typescript" \
  -f per_page=10 \
  --jq '.items | map({
    repo: .repository.full_name,
    path: .path,
    url: .html_url
  })'
