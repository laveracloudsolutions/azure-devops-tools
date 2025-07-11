# Azure DevOps Tools

Azure DevOps Tools (az cli, az devops cli, etc) | Client en ligne de commande pour Azure

## Préparation (manuelle)

```bash
# Build docker Image for "az cli"
AZ_CLI_VERSION="2.72.0"

# TODO Passer AZ_CLI_VERSION par paramètre du "docker build"
docker build -t azure-devops-tools:dev .

# Tagguer l'image
docker build -t ghcr.io/laveracloudsolutions/azure-devops-tools:${AZ_CLI_VERSION} .
docker push ghcr.io/laveracloudsolutions/azure-devops-tools:${AZ_CLI_VERSION}
```

## Docker Image | GHCR.IO | Github Action
___
> [Voir Wiki](https://dev.azure.com/petrolavera/ArchitectureApplicative/_wiki/wikis/Architecture%20applicative/340/Images-Docker-(-GitHub))
___