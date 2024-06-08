#!/bin/bash

set -e

WORKDIR=$(pwd)

REPO_DIR="$WORKDIR/apt-repo"

# create necessary directories
mkdir -p "$REPO_DIR/{conf,dists,incoming,indices,pool,db}"

# repo configuration
cat > "$REPO_DIR/conf/distributions" <<EOF
Codename: focal
Suite: stable
Components: main
Architectures: amd64
EOF

# add packages to the repo
reprepro -b "$REPO_DIR" includedeb focal "$WORKDIR/output/*.deb"
