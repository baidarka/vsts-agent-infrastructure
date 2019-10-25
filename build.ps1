# on Linux, use extension 'sh' and use hashbang: #!/bin/bash
# on Windows, use extension 'ps1' and treat as a Powershell 
docker build -t vsts-agent-infrastructure --build-arg VCS_REF="git rev-parse --short HEAD" .

# point to you own repo on Docker Hub... (or set up some form of collaboration) 
docker tag vsts-agent-infrastructure knoflook/vsts-agent-infrastructure:1.0.0
docker push knoflook/vsts-agent-infrastructure