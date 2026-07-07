# AWS DevOps Assignment - Deployment Guide

## Overview

This document describes the deployment process for the AWS DevOps Assignment. The application is deployed on an AWS EC2 Ubuntu instance using Flask, Gunicorn, and Nginx. CI/CD is implemented using GitHub Actions, monitoring is provided by Amazon CloudWatch, and backups are stored in Amazon S3.

---

# Prerequisites

* AWS Account
* GitHub Account
* SSH Key Pair
* Ubuntu EC2 Instance
* IAM Role with S3 and CloudWatch permissions

---

# Step 1: Launch EC2 Instance

* Launch an Ubuntu EC2 instance using AWS Free Tier.
* Attach an IAM Role with:

  * AmazonS3 access (least privilege)
  * CloudWatchAgentServerPolicy
* Configure the Security Group:

  * TCP 22 (SSH)
  * TCP 80 (HTTP)
  * TCP 443 (HTTPS)

---

# Step 2: Connect to EC2

```bash
ssh -i aws-key.pem ubuntu@<EC2_PUBLIC_IP>
```

---

# Step 3: Install Required Packages

```bash
sudo apt update
sudo apt install python3 python3-venv python3-pip nginx git -y
```

---

# Step 4: Clone the Repository

```bash
git clone git@github.com:aalok-akarsh/aws-devops-assignment.git
cd aws-devops-assignment
```

---

# Step 5: Create Python Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r app/requirements.txt
```

---

# Step 6: Run the Flask Application

```bash
python app/app.py
```

Verify:

```bash
curl http://localhost:5000
```

---

# Step 7: Configure Gunicorn

Create a systemd service for Gunicorn.

Reload systemd:

```bash
sudo systemctl daemon-reload
sudo systemctl enable gunicorn
sudo systemctl start gunicorn
```

Verify:

```bash
sudo systemctl status gunicorn
```

---

# Step 8: Configure Nginx

Configure Nginx as a reverse proxy to Gunicorn.

Test configuration:

```bash
sudo nginx -t
```

Restart:

```bash
sudo systemctl restart nginx
```

Verify:

```bash
curl http://localhost
```

---

# Step 9: Configure CI/CD

GitHub Actions automatically deploys the application on every push to the `main` branch.

Deployment workflow:

1. Checkout repository
2. Install Python dependencies
3. Validate Flask application
4. SSH into EC2
5. Pull latest source code
6. Install dependencies
7. Restart Gunicorn
8. Perform health check

---

# Step 10: Configure Amazon S3

An S3 bucket is used to store backups and static assets.

Access is provided through the EC2 IAM Role instead of long-term access keys.

Example verification:

```bash
aws s3 ls
```

---

# Step 11: Configure CloudWatch

Install the CloudWatch Agent.

Collect:

* CPU Metrics
* Memory Metrics
* Disk Metrics
* Nginx Logs
* System Logs

Create:

* Dashboard
* Alarms
* Log Groups

---

# Step 12: Load Testing

Install k6.

Run:

```bash
k6 run load-test/basic-test.js
```

Stress Test:

```bash
k6 run load-test/stress-test.js
```

Monitor the application using the CloudWatch Dashboard during testing.

---

# Deployment Verification Checklist

* EC2 instance running
* Flask application responding
* Gunicorn active
* Nginx active
* GitHub Actions successful
* CloudWatch metrics available
* CloudWatch logs collected
* S3 bucket accessible
* Load tests completed successfully

---

# Conclusion

The application was successfully deployed on AWS using production-oriented DevOps practices, including reverse proxy configuration, automated deployment, monitoring, centralized logging, IAM-based authentication, and performance testing.
