# Multi-stage Dockerfile to replicate the Incus orchestration logic
FROM ubuntu:noble AS base

# Install base dependencies (equivalent to iridecentimpala_setup)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    iputils-ping \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install uv in a consistent location
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR=/usr/local/bin/uv sh

# Set up shell environment for uv
ENV PATH="/usr/local/bin/uv:$PATH"
RUN echo 'export PATH="/usr/local/bin/uv:$PATH"' >> /root/.bashrc

# Final stage for the application
FROM base AS app

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
