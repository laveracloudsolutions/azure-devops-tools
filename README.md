# Azure DevOps Tools

Azure DevOps Tools (az cli, az devops cli, etc) 

> Client en ligne de commande pour Azure / Azure DevOps

## Préparation (manuelle)

```bash
# Build docker Image for "az cli"
AZ_CLI_VERSION="2.75.0"

# TODO Passer AZ_CLI_VERSION par paramètre du "docker build"
docker build -t azure-devops-tools:dev .

# Tagguer l'image
docker build -t ghcr.io/laveracloudsolutions/azure-devops-tools:${AZ_CLI_VERSION} .
docker push ghcr.io/laveracloudsolutions/azure-devops-tools:${AZ_CLI_VERSION}
```

## Utilisation (Exemple)

```bash
# Créer un PAT Azure DevOps > https://dev.azure.com/petrolavera/_usersSettings/tokens
export AZURE_DEVOPS_EXT_PAT="xxxxxxxxxxxxxxxxxxxxxxxx"

# Lancer une commande de type "az devops"
docker run --rm -e AZURE_DEVOPS_EXT_PAT "ghcr.io/laveracloudsolutions/azure-devops-tools:latest" //bin/bash -c "az devops --help"

```

## Docker Image | GHCR.IO | Github Action
___
> [Voir Wiki](https://dev.azure.com/petrolavera/ArchitectureApplicative/_wiki/wikis/Architecture%20applicative/340/Images-Docker-(-GitHub))
___