#!/usr/bin/env bash

set -euo pipefail

echo "Rolling back deployment..."

kubectl rollout undo deployment/much-todo-backend \
-n starttech

kubectl rollout status deployment/much-todo-backend \
-n starttech

echo "Rollback completed."