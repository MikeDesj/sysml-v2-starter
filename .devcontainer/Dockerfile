# Base image: Miniconda
FROM mcr.microsoft.com/devcontainers/miniconda:3

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install JupyterLab and Node.js >=20 via Conda
RUN conda install -y -c conda-forge jupyterlab "nodejs>=20"

# Fix permissions for vscode user
RUN chown -R vscode:vscode /opt/conda \
    && mkdir -p /usr/local/share/jupyter \
    && chown -R vscode:vscode /usr/local/share/jupyter