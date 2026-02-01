# Base image: Miniconda
FROM mcr.microsoft.com/devcontainers/miniconda:3

# 1. Install System Java, Graphviz, and Tools
# 'default-jdk' usually points to the latest stable (likely 17 or 21 on Debian Trixie)
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    openjdk-21-jdk \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# 2. Install JupyterLab and Node.js via Conda
RUN conda install -y -c conda-forge jupyterlab "nodejs>=20"

# --- NEW SECTION: DOWNLOAD AND INSTALL SYSML V2 KERNEL ---
# Define the release version (Update this tag as needed, e.g., 2024-11)
ARG SYSML_RELEASE=2024-11

# Download and install the kernel
RUN wget -q https://github.com/Systems-Modeling/SysML-v2-Release/archive/${SYSML_RELEASE}.zip -O sysml.zip \
    && unzip sysml.zip \
    && rm sysml.zip \
    && cd SysML-v2-Release-${SYSML_RELEASE}/install/jupyter \
    && chmod +x install.sh \
    # The install script needs to know where 'jupyter' is.
    # We force it to use the conda environment's python/jupyter
    && ./install.sh \
    # Clean up the release folder to keep the image small
    && cd / \
    && rm -rf SysML-v2-Release-${SYSML_RELEASE}
# ---------------------------------------------------------

# 3. Fix Permissions
# Give the 'vscode' user ownership of Conda AND the global Jupyter locations
# This ensures the user can write to the environment and see the kernel
RUN chown -R vscode:vscode /opt/conda \
    && mkdir -p /usr/local/share/jupyter \
    && chown -R vscode:vscode /usr/local/share/jupyter