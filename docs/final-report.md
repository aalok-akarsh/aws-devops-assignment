# AWS DevOps Engineer Technical Assignment – Final Report

## Candidate Information

**Name:** Alok Pandey

**Project:** AWS DevOps Assignment – Production-Style Flask Deployment

**Platform:** AWS Free Tier

**Repository:** https://github.com/aalok-akarsh/aws-devops-assignment

---

# 1. Objective

The objective of this project was to design, deploy, secure, monitor, and document a production-like web application using AWS Free Tier services while following DevOps best practices.

The implementation focused on infrastructure provisioning, automated deployment, security, monitoring, centralized logging, and performance validation.

---

# 2. Solution Overview

A Flask-based REST application was deployed on an Ubuntu EC2 instance.

The deployment includes:

* Nginx Reverse Proxy
* Gunicorn Application Server
* GitHub Actions CI/CD Pipeline
* Amazon CloudWatch Monitoring
* Amazon CloudWatch Logs
* Amazon S3 Backup Storage
* IAM Role-based Authentication
* k6 Performance Testing

---

# 3. AWS Services Used

| Service           | Purpose                  |
| ----------------- | ------------------------ |
| Amazon EC2        | Application Hosting      |
| Amazon IAM        | Secure Role-Based Access |
| Amazon S3         | Backup Storage           |
| Amazon CloudWatch | Monitoring & Logging     |
| Security Groups   | Firewall Configuration   |

---

# 4. Project Architecture

The deployment architecture consists of the following flow:

Developer

↓

GitHub Repository

↓

GitHub Actions Pipeline

↓

EC2 Instance (Ubuntu)

↓

Nginx Reverse Proxy

↓

Gunicorn

↓

Flask Application

CloudWatch continuously monitors system metrics and logs, while Amazon S3 stores project assets and backups.

---

# 5. Infrastructure Setup

The infrastructure was deployed using AWS Free Tier resources.

Implemented components include:

* Ubuntu EC2 Instance
* IAM Role
* Security Group
* Python Virtual Environment
* Flask Application
* Gunicorn
* Nginx
* CloudWatch Agent
* Amazon S3 Bucket

---

# 6. CI/CD Pipeline

GitHub Actions automates deployments whenever code is pushed to the **main** branch.

Pipeline steps:

1. Checkout repository
2. Configure Python
3. Install dependencies
4. Validate the Flask application
5. Connect to EC2 using SSH
6. Pull latest source code
7. Install updated dependencies
8. Restart Gunicorn
9. Execute application health check

---

# 7. Security Implementation

The following security measures were implemented:

* IAM Role with least-privilege permissions
* Security Group allowing only required ports (22, 80, 443)
* SSH key-based authentication
* Nginx reverse proxy
* Gunicorn listening only on localhost
* GitHub Secrets for deployment credentials
* CloudWatch centralized logging

---

# 8. Monitoring and Logging

Amazon CloudWatch was configured to collect:

### Metrics

* CPU Utilization
* Memory Utilization
* Disk Usage
* Network Activity

### Logs

* Nginx Access Logs
* Nginx Error Logs
* System Logs

CloudWatch Dashboards provide real-time monitoring, and CloudWatch Alarms notify administrators when configured thresholds are exceeded.

---

# 9. Load Testing

Performance testing was performed using **k6**.

## Basic Load Test

| Metric                | Result     |
| --------------------- | ---------- |
| Virtual Users         | 20         |
| Duration              | 30 seconds |
| Requests              | 600        |
| Average Response Time | 2.03 ms    |
| Error Rate            | 0%         |

## Stress Test

| Metric                | Result             |
| --------------------- | ------------------ |
| Maximum Users         | 100                |
| Total Requests        | 232,364            |
| Average Response Time | 23.07 ms           |
| Maximum Response Time | 385.40 ms          |
| Throughput            | 1,936 requests/sec |
| Error Rate            | 0%                 |

---

# 10. Performance Analysis

The application remained stable throughout the tests.

Observations:

* Zero failed requests
* Low response times under normal load
* Stable throughput during stress testing
* No service crashes
* CloudWatch metrics remained within acceptable limits

Potential improvements include horizontal scaling with an Application Load Balancer and Auto Scaling Group.

---

# 11. Challenges Faced

During implementation, several challenges were encountered:

* Configuring Nginx as a reverse proxy
* Managing Gunicorn with systemd
* Setting up GitHub Actions SSH deployment
* Configuring CloudWatch Agent permissions
* Resolving log collection permission issues
* Managing large load-testing artifacts within GitHub limits

Each issue was resolved through configuration updates, IAM policy adjustments, or repository cleanup.

---

# 12. Future Improvements

The following enhancements are recommended for production environments:

* HTTPS using Let's Encrypt or AWS Certificate Manager
* Application Load Balancer (ALB)
* Auto Scaling Group
* Docker containerization
* Kubernetes deployment
* Terraform Infrastructure as Code
* Ansible configuration management
* AWS WAF integration
* Amazon RDS for persistent database storage
* CloudFront for content delivery

---

# 13. Conclusion

This project successfully demonstrates the deployment of a production-style Flask application on AWS using DevOps best practices.

The solution includes secure infrastructure, automated CI/CD, centralized monitoring, logging, load testing, and comprehensive documentation while remaining compatible with AWS Free Tier.

The project provides a strong foundation for extending the application into a scalable, highly available production environment.
