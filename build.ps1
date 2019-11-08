<#
.SYNOPSIS
    Docker build and push.
#>
[CmdletBinding()]
param(
    [String]$Registry="knoflook",
    [String]$ImageName="vsts-agent-infrastructure",
    [String]$Tag="1.0.1"    
)

function Start-Build {
    param(
        [Parameter (Mandatory=$true, HelpMessage="The name of your Docker registry.")]
        [ValidateNotNullOrEmpty()]
        [String]$Registry,

        [Parameter (Mandatory=$true, HelpMessage="Name of your Docker image.")]
        [ValidateNotNullOrEmpty()]
        [String]$ImageName,
    
        [Parameter (Mandatory=$true, HelpMessage="Version tag.")]
        [ValidateNotNullOrEmpty()]
        [String]$Tag
    )

    docker build -t $Registry/$ImageName`:$Tag --build-arg VCS_REF="git rev-parse --short HEAD" .
    docker push $Registry/$ImageName
}

#-------------------------------------------------------
$ErrorActionPreference = "stop"
Start-Build -Registry $Registry -ImageName $ImageName -Tag $Tag
