# vyos-apt

This repository contains the configuration and scripts necessary to build VyOS packages and update an APT repository automatically using Jenkins and Docker. It also includes steps to upload the repository to Cloudflare R2.

## Directory Structure

- `Jenkinsfile`: Jenkins pipeline configuration.
- `Dockerfile`: Docker image configuration for building packages.
- `scripts/build_packages.sh`: Script to build VyOS packages.
- `scripts/update_repo.sh`: Script to update the APT repository.
- `scripts/upload_repo.sh`: Script to upload the repository to Cloudflare R2.
- `conf/distributions`: APT repository configuration.
- `.env.example`: Example environment configuration file.

## How to Use

1. **Set Up a Jenkins Server:**
   Install Jenkins on your server. Follow the [Jenkins installation guide](https://www.jenkins.io/doc/book/installing/) for detailed instructions.

2. **Create a New Pipeline Job in Jenkins:**
   - In Jenkins, create a new pipeline job and point it to this repository.
   - Configure the job to use the `Jenkinsfile` provided in this repository.

3. **Configure Cloudflare R2:**
   - Set up a Cloudflare R2 bucket.
   - Configure your AWS CLI with a profile for Cloudflare R2.

4. **Create a `.env` File:**
   - Create a `.env` file in the root of this repository based on the `.env.example` file.
   - Fill in the necessary details such as `BUCKET_NAME`, `AWS_PROFILE`, `REPO_URL`, and `PACKAGE_LIST`.

5. **Run the Pipeline:**
   - The pipeline will automatically build the VyOS packages daily, update the APT repository, and upload the repository to Cloudflare R2.

## Dependencies

- Jenkins
- Docker
- reprepro
- debuild
- AWS CLI

## Contributions

Feel free to contribute improvements and new packages!
