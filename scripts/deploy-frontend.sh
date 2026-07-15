#!/usr/bin/env bash

set -euo pipefail

REGION="us-east-1"
BUCKET_NAME="${S3_BUCKET:?S3_BUCKET is not set}"
DISTRIBUTION_ID="${CLOUDFRONT_DISTRIBUTION_ID:?CLOUDFRONT_DISTRIBUTION_ID is not set}"

cd "$(dirname "$0")/../frontend"

echo "Installing dependencies..."
npm ci

echo "Building frontend..."
npm run build

echo "Uploading to S3..."
aws s3 sync dist "s3://${BUCKET_NAME}" --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
  --distribution-id "$DISTRIBUTION_ID" \
  --paths "/*"

echo "Frontend deployment completed."