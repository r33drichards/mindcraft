# Specify a base image
FROM node:22-bullseye

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        python3 \
        python3-pip \
        python3-boto3 \
        python3-tqdm \
        tmux \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Ensure 'python' points to 'python3'
RUN ln -sf /usr/bin/python3 /usr/bin/python

WORKDIR /mindcraft

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

# Optionally install Python requirements for tasks
RUN if [ -f requirements.txt ]; then pip3 install --no-cache-dir -r requirements.txt; fi

# Default command (can be overridden)
CMD ["node", "main.js"]
