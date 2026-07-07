# AWS DevOps Assignment – Architecture Documentation

## Overview

This project demonstrates a production-style deployment of a Flask web application on AWS Free Tier using modern DevOps practices. The solution incorporates automated deployment, centralized monitoring, secure infrastructure configuration, and performance testing.

---

# Architecture Components

## 1. GitHub Repository

The source code is maintained in a GitHub repository.

Repository contents include:

* Flask application source code
* GitHub Actions workflow
* Nginx configuration
* Gunicorn configuration
* CloudWatch configuration
* Load testing scripts
* Project documentation

---

## 2. GitHub Actions CI/CD

Every push to the **main** branch automatically triggers the deployment pipeline.

Pipeline workflow:

1. Checkout source code
2. Configure Python environment
3. Install dependencies
4. Validate the Flask application
5. Connect to the EC2 instance using SSH
6. Pull the latest code
7. Install updated dependencies
8. Restart the Gunicorn service
9. Perform an application health check

This automation reduces manual deployment effort and ensures consistent releases.

---

## 3. AWS EC2 Instance

The application is hosted on an Ubuntu EC2 instance.

The EC2 instance contains:

* Python runtime
* Flask application
* Gunicorn application server
* Nginx reverse proxy
* CloudWatch Agent
* AWS CLI

An IAM Role is attached to the instance to securely access AWS services without storing access keys.

---

## 4. Nginx Reverse Proxy

Nginx acts as the public-facing web server.

Responsibilities include:

* Receiving incoming HTTP requests
* Forwarding requests to Gunicorn
* Serving as the reverse proxy
* Isolating the application server from direct internet access

---

## 5. Gunicorn Application Server

Gunicorn executes the Flask application.

Configuration highlights:

* Bound to **127.0.0.1:8000**
* Managed by **systemd**
* Automatically starts on system boot
* Restarted automatically during deployment

---

## 6. Flask Application

The Flask application provides REST API endpoints and serves as the business logic layer.

The application is deployed inside a Python virtual environment to isolate project dependencies.

---

## 7. Amazon S3

Amazon S3 is used to store backups and project assets.

Access is provided through the EC2 IAM Role using temporary AWS credentials.

No long-term AWS access keys are stored on the server.

---

## 8. Amazon CloudWatch

Amazon CloudWatch provides centralized monitoring and logging.

Collected metrics include:

* CPU utilization
* Memory utilization
* Disk utilization
* Network traffic

Collected logs include:

* Nginx access logs
* Nginx error logs
* System logs

CloudWatch Dashboards provide real-time visualization, while CloudWatch Alarms notify administrators when configured thresholds are exceeded.

---

# Request Flow

The following sequence describes how a client request is processed:

1. A client sends an HTTP request.
2. The request reaches the EC2 instance.
3. Nginx receives the request.
4. Nginx forwards the request to Gunicorn.
5. Gunicorn invokes the Flask application.
6. Flask processes the request and generates a response.
7. Gunicorn returns the response to Nginx.
8. Nginx sends the response back to the client.

---

# Deployment Flow

Application deployment follows this sequence:

1. Developer pushes code to GitHub.
2. GitHub Actions pipeline starts automatically.
3. The workflow validates the application.
4. GitHub Actions connects to EC2 using SSH.
5. Latest code is pulled from GitHub.
6. Python dependencies are updated.
7. Gunicorn service is restarted.
8. A health check verifies successful deployment.

---

# Monitoring Flow

Operational monitoring follows this sequence:

1. CloudWatch Agent collects system metrics and logs.
2. Metrics are published to Amazon CloudWatch.
3. Logs are stored in CloudWatch Log Groups.
4. Dashboards display system health.
5. Alarms monitor resource utilization and notify administrators when thresholds are exceeded.

---

# Security Architecture

Security controls implemented include:

* IAM Role with least-privilege permissions
* Security Group allowing only required ports
* SSH key-based authentication
* Gunicorn bound to localhost
* Nginx reverse proxy
* GitHub Secrets for deployment credentials
* CloudWatch monitoring and centralized logging

---

# Scalability Considerations

Although this project targets AWS Free Tier, it can be extended by adding:

* Application Load Balancer (ALB)
* Auto Scaling Group
* Amazon RDS
* Amazon ElastiCache
* Amazon CloudFront
* HTTPS using AWS Certificate Manager or Let's Encrypt

---

# Conclusion

The implemented architecture follows common DevOps deployment practices by combining automated CI/CD, secure infrastructure, centralized monitoring, and production-style application hosting. The design is modular, scalable, and suitable as a foundation for future enhancements.
