# Base image: Miniconda
FROM mcr.microsoft.com/devcontainers/miniconda:3

# 1. Install System Java, Graphviz, and Tools
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    openjdk-21-jdk \
    graphviz \
    && rm -rf /var/lib/apt/lists/*

# 2. Install JupyterLab and Node.js via Conda
RUN conda install -y -c conda-forge jupyterlab "nodejs>=20"

# --- SYSML V2 TOOL INSTALLATION ---
ARG PILOT_TAG=2025-12
ARG KERNEL_VERSION=0.55.0

# 1. SEARCH & DEPLOY
# We download to a 'raw' folder and use broader search patterns
RUN wget -q https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation/releases/download/${PILOT_TAG}/jupyter-sysml-kernel-${KERNEL_VERSION}.zip -O sysml-kernel.zip \
    && unzip -q sysml-kernel.zip -d /opt/sysml-raw \
    && rm sysml-kernel.zip \
    
    # DEBUG: List files so we know what we are dealing with if this fails
    && echo "--- CONTENTS OF ZIP ---" \
    && ls -R /opt/sysml-raw \
    && echo "-----------------------" \
    
    # FIND THE JAR (Matches ANY .jar file now)
    && JAR_PATH=$(find /opt/sysml-raw -name "*.jar" | head -n 1) \
    && if [ -z "$JAR_PATH" ]; then echo "ERROR: No JAR file found!"; exit 1; fi \
    && echo "Found JAR at: $JAR_PATH" \
    
    # FIND THE INSTALL SCRIPT (Matches install.sh or similar)
    && INSTALL_SCRIPT=$(find /opt/sysml-raw -name "install.sh" | head -n 1) \
    
    # MOVE everything to /opt/sysml-v2
    # We move the *parent directory* of the jar to ensure we keep lib folders intact
    && JAR_DIR=$(dirname "$JAR_PATH") \
    && mv "$JAR_DIR" /opt/sysml-v2 \
    && rm -rf /opt/sysml-raw \
    
    # RUN INSTALLER (If found)
    && if [ ! -z "$INSTALL_SCRIPT" ]; then \
         # We must locate the script in the NEW location (/opt/sysml-v2)
         NEW_SCRIPT_PATH="/opt/sysml-v2/$(basename "$INSTALL_SCRIPT")"; \
         if [ -f "$NEW_SCRIPT_PATH" ]; then \
            chmod +x "$NEW_SCRIPT_PATH"; \
            cd /opt/sysml-v2 && "$NEW_SCRIPT_PATH"; \
         fi \
       fi \
    
    # CREATE CLI TOOL
    # We verify the moved jar location dynamically
    && FINAL_JAR=$(find /opt/sysml-v2 -name "*.jar" | head -n 1) \
    && echo '#!/bin/bash' > /usr/local/bin/sysml \
    && echo "java -jar $FINAL_JAR \"\$@\"" >> /usr/local/bin/sysml \
    && chmod +x /usr/local/bin/sysml

# 4. Download Standard Libraries
RUN git clone --depth 1 https://github.com/Systems-Modeling/SysML-v2-Release.git /opt/sysml-v2-libraries \
    && echo "export SYSML_PATH=/opt/sysml-v2-libraries" >> /etc/bash.bashrc

# 3. Fix Permissions
RUN chown -R vscode:vscode /opt/conda \
    && mkdir -p /usr/local/share/jupyter \
    && chown -R vscode:vscode /usr/local/share/jupyter \
    && chown -R vscode:vscode /opt/sysml-v2