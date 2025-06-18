# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y tmux vim && \
    apt-get install -y curl gnupg ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Verify Node.js and npm installed (optional but good for debugging)
RUN node -v && npm -v

# Set the working directory
#WORKDIR /app

# Copy package.json and package-lock.json
#COPY package*.json ./


# Install dependencies
#RUN npm install

# Copy application source code
#COPY . .

WORKDIR /app
COPY ./app/package*.json ./
RUN npm install
COPY ./app .
CMD ["node", "index.js"]

# Expose the port your app listens on
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]

