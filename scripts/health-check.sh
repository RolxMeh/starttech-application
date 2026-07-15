#!/usr/bin/env bash

set -euo pipefail

URL="${1:-https://d1yiiqufgmzmmn.cloudfront.net/api/health}"

echo "Checking ${URL}"

curl -fsSL "$URL"

echo
echo "Health check passed."