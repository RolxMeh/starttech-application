#!/usr/bin/env bash

set -euo pipefail

URL="${1:-https://ddxojilxslbxu.cloudfront.net/api/v1/health}"

echo "Checking ${URL}"

curl -fsSL "$URL"

echo
echo "Health check passed."