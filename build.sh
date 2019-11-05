#!/bin/bash

function usage() {
    echo "Usage: build.sh REGISTRY"
}

registry="$1"

if [ -z "$registry" ]; then
    usage
    exit 1
fi

docker build -t vsts-agent-infrastructure --build-arg VCS_REF="git rev-parse --short HEAD" .

# point to you own repo on Docker Hub... (or set up some form of collaboration) 
docker tag vsts-agent-infrastructure "$registry"/vsts-agent-infrastructure:1.0.0
docker push "$registry"/vsts-agent-infrastructure