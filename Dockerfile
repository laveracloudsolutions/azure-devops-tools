# docker build -t azure-devops-tools:dev .
FROM ubuntu:26.04

# Store an Azure CLI version of choice
ENV AZURE_CLI_VERSION=2.88.*

# Upgrade Image
RUN apt-get update  && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends -qy \
      apt-transport-https ca-certificates curl gnupg lsb-release libicu-dev jq git python3 python3-venv python3-pip tini unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Azure Cli (on force ici le dépot "noble" en attendant la mise à disposition sur un depot "resolute")
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
         gpg --dearmor | \
         tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null \
         && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ noble main" | \
         tee /etc/apt/sources.list.d/azure-cli.list

RUN apt-get update
RUN apt-get install -qy azure-cli=${AZURE_CLI_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Azure Devops Cli Extension
RUN az extension add --name azure-devops

# Create Working Directory
RUN mkdir -p /code

# Make python3 available as python
RUN ln -s /usr/bin/python3 /usr/bin/python || true

# pip upgrade and install jinja2-cli + jinja2
RUN python3 -m pip install --break-system-packages --no-cache-dir pip setuptools wheel jinja2-cli jinja2 && \
    rm -rf /root/.cache/pip

# Install aider-ai (https://aider.chat/)
# Note: aider-install relies on "uv tool install", which tries to add
# /root/.local/bin to PATH via "uv tool update-shell". This fails during
# a Docker build (no interactive shell to detect/edit), so we pre-add
# the directory to PATH to skip that step entirely.
# ENV PATH="/root/.local/bin:${PATH}"
# NB: uv garde par défaut un cache de téléchargement/build (~600 Mo) dans
# /root/.cache/uv en plus du venv installé: on le nettoie ici, dans le même
# layer que l'installation (un nettoyage dans un RUN séparé ne réduirait pas
# la taille de l'image).
# RUN python3 -m pip install --break-system-packages --no-cache-dir aider-install && \
#    aider-install && \
#    rm -rf /root/.cache/uv /root/.cache/pip

# Set Default Git Config
RUN git config --global user.email "ado.bot@orange.com" && git config --global user.name "ado.bot"