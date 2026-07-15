# StartTech Application

## Overview

This repository contains the application source code for the StartTech DevOps Engineering Assessment.

The application consists of:

* **Frontend:** React + Vite
* **Backend:** Golang REST API
* **Containerization:** Docker
* **Container Registry:** Amazon Elastic Container Registry (ECR)
* **Container Orchestration:** Amazon Elastic Kubernetes Service (EKS)

The frontend is deployed as a static website to Amazon S3 and served through Amazon CloudFront, while the backend runs inside an EKS cluster.

---

# Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── backend-ci-cd.yml
│       └── frontend-ci-cd.yml
├── backend/
├── frontend/
├── k8s/
├── scripts/
└── README.md
```

---

# Technology Stack

## Frontend

* React
* Vite
* TypeScript
* Nginx (Docker image)

## Backend

* Golang
* REST API

## DevOps

* Docker
* Kubernetes
* Amazon EKS
* Amazon ECR
* Amazon S3
* Amazon CloudFront
* GitHub Actions

---

# Architecture

```text
Users
   │
   ▼
CloudFront
   │
   ▼
Amazon S3
   │
   ▼
Frontend (React)

            │
            ▼

Amazon EKS
   │
   ▼
Backend API (Go)

   │
   ├── MongoDB Atlas
   └── Amazon ElastiCache (Redis)
```

---

# Kubernetes Resources

The repository contains Kubernetes manifests for:

* Backend Deployment
* Backend Service
* ConfigMaps
* Secrets (template only)

The frontend is hosted on S3 and therefore is not deployed to Kubernetes.

---

# Environment Variables

## Frontend

```env
VITE_API_BASE_URL=/api
```

---

## Backend

Backend configuration is provided through Kubernetes ConfigMaps and Secrets.

Examples include:

* MongoDB Connection String
* Redis Connection String
* Application Configuration

---

# Docker

## Backend

Build image

```bash
docker build -t starttech-backend-api ./backend
```

---

## Frontend

Build image

```bash
docker build -t starttech-frontend ./frontend
```

---

# CI/CD

GitHub Actions automates deployment.

## Backend Pipeline

The backend workflow performs:

* Checkout source
* Configure AWS credentials
* Authenticate to Amazon ECR
* Build Docker image
* Push image to Amazon ECR
* Update Amazon EKS deployment
* Wait for successful rollout

---

## Frontend Pipeline

The frontend workflow performs:

* Install dependencies
* Build production assets
* Upload build artifacts to Amazon S3
* Invalidate CloudFront cache

---

# Deployment Scripts

The repository includes helper scripts for deployment.

```text
scripts/
├── deploy-backend.sh
├── deploy-frontend.sh
├── health-check.sh
└── rollback.sh
```

---

# Health Check

Backend health endpoint

```text
GET /api/health
```

Example

```bash
curl https://<cloudfront-domain>/api/health
```

---

# Local Development

## Backend

```bash
cd backend

go mod download

go run main.go
```

---

## Frontend

```bash
cd frontend

npm install

npm run dev
```

---

# Deployment

Backend

```bash
./scripts/deploy-backend.sh
```

Frontend

```bash
./scripts/deploy-frontend.sh
```

---

# Rollback

```bash
./scripts/rollback.sh
```

---

# Author

Ayotunde