# InfraAutomate: Deploying Uptime Kuma on AWS with Terraform & Docker

## 🚀 Project Overview

InfraAutomate is a real-world DevOps project where I deployed [Uptime Kuma](https://github.com/louislam/uptime-kuma), a self-hosted monitoring app, on AWS EC2 using Terraform and Docker.

The goal is to replicate what DevOps engineers do in real jobs: provision infrastructure, deploy containerized apps, and manage infrastructure as code.

---

## 🧰 Tech Stack

- **AWS EC2** – Cloud server for hosting the app  
- **Terraform** – Infrastructure as Code (IaC) to automate AWS setup  
- **Docker & Docker Compose** – For app containerization and deployment  

---

## 🧱 Architecture

![Architecture Diagram](screenshots/architecture-diagram.png)

---

## ⚙️ Deployment Steps

### 1. ✅ Provision AWS Infrastructure with Terraform

```bash
cd terraform
terraform init
terraform apply -auto-approve
