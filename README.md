# Azure DevOps Agent Docker Image

This repo contains the infrastructure and image definition that accompanies the blogpost [How to create a custom VSTS agent on Azure ACI with Terraform](https://cloudblogs.microsoft.com/opensource/2018/05/22/how-to-create-vsts-agent-azure-aci-terraform/) by Elena Neroslavskaya.
When implementing infrastructure as code (IaC) with Azure, it is useful to have some infrastructure tools available on your build agent. This repo contains files to:
- create a custom build agent that contains [Terraform](https://www.terraform.io/), [Packer](https://www.packer.io/) and [Ansible](https://www.ansible.com/)
- create an Azure Container Instances (ACI) resource to run the custom build agent

A pre-built image (possibly older) is available on Docker Hub under [lenisha/vsts-agent-infrastructure](https://hub.docker.com/r/lenisha/vsts-agent-infrastructure)

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lenisha/vsts-agent-infrastructure.svg)](https://registry.hub.docker.com/u/lenisha/vsts-agent-infrastructure)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/lenisha/vsts-agent-infrastructure.svg)](https://registry.hub.docker.com/u/lenisha/vsts-agent-infrastructure) [![](https://images.microbadger.com/badges/image/lenisha/vsts-agent-infrastructure.svg)](https://microbadger.com/images/lenisha/vsts-agent-infrastructure "Get your own image badge on microbadger.com")

## How to use this repo

1 Create an Agent Pool named "ACI-Pool" in your Azure DevOps organisation.

2 Prepare environment variables:

- `VSTS_ACCOUNT`: the name of your Visual Studio account
- `VSTS_TOKEN`: a personal access token (PAT) for your Visual Studio account, with **Agent Pools (read, manage)** and **Deployment Groups (Read & manage)**.
- `VSTS_AGENT`: the name of the agent (here: `"$(hostname)-agent"`)
- `VSTS_POOL`: the name of your agent pool (here: `"ACI-Pool"`)

## Notes

- TODO: add automatic updates when new release posted

- Other tools installed on VSTS image are listed:
[vsts agent tools](https://github.com/Microsoft/vsts-agent-docker/blob/6689c2bd45304ec56d2628f393355b52a451453e/README.md#standard-images)

- If you want to run this image as a standalone container use:

```BASH
docker run \
  -e VSTS_ACCOUNT=<name> \
  -e VSTS_TOKEN=<pat> \
  -e VSTS_AGENT='$(hostname)-agent' \
  -e VSTS_POOL=ACI-pool \
  -it [lenisha/vsts-agent-infrastructure](https://github.com/lenisha/vsts-agent-infrastructure)
```