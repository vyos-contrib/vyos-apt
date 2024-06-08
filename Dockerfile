# Use the official Debian image as a base
FROM debian:12

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    devscripts \
    git \
    reprepro \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the build scripts into the container
COPY scripts/ /workspace/scripts/

# Copy the configuration files into the container
COPY conf/ /workspace/conf/

# Copy the .env file into the container
COPY .env /workspace/

# Make the build scripts executable
RUN chmod +x /workspace/scripts/*.sh

# Define the entrypoint script
ENTRYPOINT ["/workspace/scripts/build_packages.sh"]
