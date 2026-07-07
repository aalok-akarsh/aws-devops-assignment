# AWS DevOps Assignment – Security Summary

## Overview

Security was considered throughout the deployment to protect infrastructure, application access, and AWS resources. The implementation follows the principle of least privilege and uses AWS-native security controls wherever possible.

---

# 1. Identity and Access Management (IAM)

An IAM Role was attached to the EC2 instance instead of storing AWS access keys on the server.

### Attached Permissions

* Custom S3 Backup Policy
* CloudWatchAgentServerPolicy

### Benefits

* No hardcoded AWS credentials
* Temporary credentials managed automatically
* Reduced risk of credential leakage

---

# 2. Security Groups

The EC2 Security Group was configured to allow only the required network traffic.

| Port | Protocol | Purpose                |
| ---- | -------- | ---------------------- |
| 22   | TCP      | SSH administration     |
| 80   | TCP      | HTTP web traffic       |
| 443  | TCP      | HTTPS (future support) |

All other inbound traffic remains blocked by default.

---

# 3. SSH Security

The EC2 instance is accessed using SSH key authentication.

Security measures include:

* SSH private key authentication
* No password-based login
* Restricted access through Security Groups

---

# 4. Reverse Proxy Security

Nginx is configured as the public-facing web server.

Responsibilities:

* Receives client requests
* Forwards requests to Gunicorn
* Hides the application server from direct internet access

This provides an additional security layer between users and the Flask application.

---

# 5. Gunicorn Configuration

Gunicorn is bound only to the local interface:

127.0.0.1:8000

This ensures the application server cannot be accessed directly from the internet.

All external requests must pass through Nginx.

---

# 6. CloudWatch Monitoring

Amazon CloudWatch provides operational visibility by collecting:

* CPU utilization
* Memory utilization
* Disk usage
* Nginx logs
* System logs
* Application metrics

CloudWatch dashboards and alarms help detect abnormal system behavior and support troubleshooting.

---

# 7. Secure S3 Access

Amazon S3 is used for backups and static assets.

Security controls include:

* IAM Role-based authentication
* No embedded AWS credentials
* Least-privilege access policy
* Private bucket configuration

---

# 8. CI/CD Security

GitHub Actions automates deployments.

Sensitive information is stored using GitHub Secrets, including:

* EC2 Host
* SSH Username
* SSH Private Key

Secrets are encrypted and never stored in the source code repository.

---

# 9. Logging and Auditing

System and application logs are collected through Amazon CloudWatch.

Collected logs include:

* Nginx access logs
* Nginx error logs
* System logs

Centralized logging improves monitoring, troubleshooting, and operational visibility.

---

# 10. Future Security Improvements

The following enhancements are recommended for a production environment:

* Enable HTTPS using Let's Encrypt or AWS Certificate Manager.
* Deploy an Application Load Balancer (ALB).
* Enable AWS WAF for web application protection.
* Configure AWS Shield Standard for DDoS protection.
* Use AWS Secrets Manager or Systems Manager Parameter Store for application secrets.
* Implement Multi-AZ deployment for higher availability.

---

# Conclusion

The project implements core AWS and DevOps security best practices, including IAM least privilege, secure network configuration, reverse proxy deployment, centralized monitoring, encrypted secret management through GitHub Actions, and secure AWS resource access. These controls provide a strong security foundation while remaining compatible with AWS Free Tier resources.
