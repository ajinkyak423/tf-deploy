# tf-deploy

## Assignment Overview

Deployment of a simple Python Flask application on AWS EC2 using Docker and Infrastructure as Code (IaC) with Terraform. The project also includes a CI/CD pipeline using GitHub Actions for automated Docker image build and deployment.

---

## Project Structure

- `app/` : Contains the Flask application and its requirements.
- `Dockerfile` : Docker configuration to containerize the Flask app.
- `terraform/` : Terraform scripts to provision AWS infrastructure (VPC, subnet, EC2, EBS, security, etc).
- `.github/workflows/deploy.yml` : GitHub Actions workflow for CI/CD.

---

## Application Details

The Flask app exposes a single endpoint `/api/v1` that returns a random word from a predefined list. It listens on port 8081.

---

## Dockerization

The app is containerized using a multi-step Dockerfile:

1. Uses a slim Python base image.
2. Installs dependencies from `requirements.txt` (Flask).
3. Copies the app code and exposes port 8081.
4. The container runs the Flask app on startup.

---

## Infrastructure as Code (Terraform)

The `terraform/` directory provisions the following AWS resources:

- **VPC** and **Subnet**: Isolated network for the app.
- **EC2 Instance**: Ubuntu server to host the Dockerized app.
- **EBS Volume**: 10GB encrypted storage attached to the EC2 instance.
- **Security Group**: Allows SSH (22) and app traffic (8081).
- **KMS Key**: For EBS encryption.
- **Outputs**: Public IP of the EC2 instance for access and deployment.

The EC2 instance is bootstrapped with Docker via `user_data` and is ready to run containers.

---

## CI/CD Pipeline (GitHub Actions)

The workflow automates:

1. **Build & Push Docker Image**: On push to main or with a trigger, the Docker image is built and pushed to Docker Hub.
2. **Deploy to EC2**: SSHs into the EC2 instance and pulls the latest image, then restarts the container.
3. **Conditional Build and Deploy**: Build can be triggered using BUILD_CONTAINER_IMAGE sting in commit message else it will be auto triggered once merged in main branch along with deploy workflow.



---

## Approach Summary

1. **App Development**: Simple, stateless Flask API.
2. **Containerization**: Ensures portability and consistency across environments.
3. **Infrastructure as Code**: Reproducible, version-controlled AWS setup.
4. **Security**: Uses KMS for EBS encryption, restricts access via security groups.
5. **Automation**: GitHub Actions for seamless build and deployment.

---

## Notes

- The EBS volume is attached to the EC2 instance but not auto-formatted/mounted on every boot to prevent data loss.
- The public IP output from Terraform should be used to configure the CI/CD pipeline.
- Ensure AWS credentials and SSH keys are managed securely.

