# a file named terraform.tfvars is automatically loaded
variable "vsts-account" {
  default = ""
}

variable "vsts-token" {
  default = ""
}

variable "vsts-agent" {
  default = "ACI-Agent1"
}

variable "vsts-pool" {
  default = "ACI-Pool"
}
