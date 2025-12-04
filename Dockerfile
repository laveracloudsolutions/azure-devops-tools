# docker build -t azure-devops-tools:dev .
FROM ubuntu:24.04

# Store an Azure CLI version of choice
ENV AZURE_CLI_VERSION=2.75.*

# Upgrade Image
RUN apt-get update  && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends -qy \
      apt-transport-https ca-certificates curl gnupg lsb-release libicu-dev jq git python3 python3-venv python3-pip tini unzip

# Install Azure Cli
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
         gpg --dearmor | \
         tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null \
         && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | \
         tee /etc/apt/sources.list.d/azure-cli.list

RUN apt-get update
RUN apt-get install -qy azure-cli=${AZURE_CLI_VERSION}

# Install Azure Devops Cli Extension
RUN az extension add --name azure-devops

# Create Working Directory
RUN mkdir -p /code

# Make python3 available as python
RUN ln -s /usr/bin/python3 /usr/bin/python || true

# pip upgrade and install jinja2-cli + jinja2
RUN python3 -m pip install --break-system-packages --no-cache-dir pip setuptools wheel jinja2-cli jinja2

# Set Default Git Config
RUN git config --global user.email "ado.bot@orange.com" && git config --global user.name "ado.bot"