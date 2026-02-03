#!/bin/bash
# Match an idea to relevant GitHub repos
# Usage: ./idea-matcher.sh "idea description"

IDEA="$1"
if [ -z "$IDEA" ]; then
  echo "Usage: ./idea-matcher.sh 'idea description'"
  exit 1
fi

# Search GitHub for matching repos
gh api search/repositories \
  -X GET \
  -f q="$IDEA stars:>20" \
  -f sort=stars \
  -f per_page=5 \
  --jq '.items | map({
    name: .full_name,
    description: .description,
    stars: .stargazers_count,
    url: .html_url,
    language: .language
  })'
