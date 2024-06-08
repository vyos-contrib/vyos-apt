#!/bin/bash

set -e

# Load environment variables from .env file
source .env

# Define the working directory
WORKDIR=$(pwd)

# Clone the VyOS repository
git clone https://github.com/vyos/vyos-build.git
cd vyos-build/packages

# Convert the comma-separated package list into an array
IFS=',' read -r -a packages <<< "$PACKAGE_LIST"

# Build each package
for pkg in "${packages[@]}"; do
    cd "$pkg"
    # Build the package using debuild
    debuild -b -us -uc
    cd ..
done

# Copy built packages to the output directory
mkdir -p "$WORKDIR/output"
cp ../*.deb "$WORKDIR/output"
