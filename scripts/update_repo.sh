#!/bin/bash

set -e

# Define the working directory
WORKDIR=$(pwd)

# Define the APT repository directory
REPO_DIR="$WORKDIR/apt-repo"

# Create necessary directories
mkdir -p "$REPO_DIR/conf"
mkdir -p "$REPO_DIR/dists/debian-12/main/binary-amd64"
mkdir -p "$REPO_DIR/pool/main"

# Configuration of the APT repository
cat > "$REPO_DIR/conf/distributions" <<EOF
Codename: debian-12
Suite: stable
Components: main
Architectures: amd64
EOF

# Add packages to the repository
reprepro -b "$REPO_DIR" includedeb debian-12 "$WORKDIR/output/*.deb"
