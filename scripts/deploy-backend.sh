#!/usr/bin/env bash

set -euo pipefail

REGION="us-east-1"
CLUSTER_NAME="starttech-cluster"
ECR_REPOSITORY="starttech-backend-api"
IMAGE_TAG="${1:-latest}"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

IMAGE_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"

echo "Logging into ECR..."
aws ecr get-login-password --region "$REGION" | docker login \
    --username AWS \
    --password-stdin "${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"

echo "Building Docker image..."
docker build -t "$IMAGE_URI" ../backend

echo "Pushing image..."
docker push "$IMAGE_URI"

echo "Updating kubeconfig..."
aws eks update-kubeconfig \
    --region "$REGION" \
    --name "$CLUSTER_NAME"

echo "Updating deployment image..."
kubectl set image deployment/much-todo-backend \
backend="$IMAGE_URI" \
-n starttech

echo "Waiting for rollout..."
kubectl rollout status deployment/much-todo-backend \
-n starttech