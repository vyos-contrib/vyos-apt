#!/bin/bash

set -e

# packages to build
packages=("keepalived" "ethtool")

WORKDIR=$(pwd)

git clone https://github.com/vyos/vyos-build.git
cd vyos-build/packages


# build each package
for pkg in "${packages[@]}"; do
    cd "$pkg"
    debuild -b -us -uc
    cd ..
done

# copy the packages to the output directory
mkdir -p "$WORKDIR/output"
cp ../*.deb "$WORKDIR/output"
