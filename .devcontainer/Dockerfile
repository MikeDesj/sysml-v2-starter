# Base image: Miniconda
FROM mcr.microsoft.com/devcontainers/miniconda:3

# Install System Java, Graphviz, and Tools
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    openjdk-17-jdk \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# FIX: Pre-install Node.js v20+ (Required by the SysML script)
# and JupyterLab via Conda-forge
RUN conda install -y -c conda-forge jupyterlab "nodejs>=20"

# FIX: Give the 'vscode' user ownership of Conda
# This ensures the user can write to the environment we just created
RUN chown -R vscode:vscode /opt/conda