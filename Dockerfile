# docker build -t azure-devops-tools:dev .
FROM ubuntu:24.04

# Store an Azure CLI version of choice
ENV AZURE_CLI_VERSION=2.72.*

# Upgrade Image
RUN apt-get update  && \
    apt-get dist-upgrade -y && \
    apt-get install -qy \
      apt-transport-https ca-certificates curl gnupg lsb-release libicu-dev jq git

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