#!/bin/bash

function usage() {
    echo "Usage: build.sh REGISTRY"
}

registry="$1"

if [ -z "$registry" ]; then
    usage
    exit 1
fi

docker build -t "$registry"/vsts-agent-infrastructure:1.0.0 --build-arg VCS_REF="git rev-parse --short HEAD" .
docker push "$registry"/vsts-agent-infrastructure