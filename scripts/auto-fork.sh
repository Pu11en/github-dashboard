#!/bin/bash
# Auto-fork a repo to Pu11en account
# Usage: ./auto-fork.sh owner/repo

REPO="$1"
if [ -z "$REPO" ]; then
  echo "Usage: ./auto-fork.sh owner/repo"
  exit 1
fi

gh repo fork "$REPO" --clone=false
echo "Forked $REPO to Pu11en account"
