#!/bin/bash

set -e

# Load environment variables from .env file
source .env

# Define the working directory
WORKDIR=$(pwd)

# Install AWS CLI if not already installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI not found, installing..."
    pip install awscli
fi

# Configure AWS CLI to use the specified profile
export AWS_PROFILE=$AWS_PROFILE

# Upload the APT repository to Cloudflare R2
aws s3 sync "$WORKDIR/apt-repo" "s3://$BUCKET_NAME" --delete