resource "azurerm_resource_group" "rg-cicd" {
  name     = "rg-cicd-tst-001"
  location = "West Europe"
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${azurerm_resource_group.rg-cicd.name}"
  }

  byte_length = 8
}

resource "azurerm_storage_account" "st-cicd" {
  name                = "stcicd${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.rg-cicd.name}"
  location            = "${azurerm_resource_group.rg-cicd.location}"
  account_tier        = "Standard"

  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "share-cicd" {
  name                 = "stsharecicd"
  resource_group_name  = "${azurerm_resource_group.rg-cicd.name}"
  storage_account_name = "${azurerm_storage_account.st-cicd.name}"

  quota = 50
}

resource "azurerm_container_group" "cocicd" {
  name                = "aci-agent1"
  location            = "${azurerm_resource_group.rg-cicd.location}"
  resource_group_name = "${azurerm_resource_group.rg-cicd.name}"
  ip_address_type     = "public"
  os_type             = "linux"

  container {
    name   = "azure-devops-agent"
    image  = "knoflook/vsts-agent-infrastructure"
    cpu    = "0.5"
    memory = "1.5"
    port   = "80"

    environment_variables {
      "VSTS_ACCOUNT" = "${var.vsts-account}"
      "VSTS_TOKEN"   = "${var.vsts-token}"
      "VSTS_AGENT"   = "${var.vsts-agent}"
      "VSTS_POOL"    = "${var.vsts-pool}"
    }

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = "${azurerm_storage_share.share-cicd.name}"

      storage_account_name = "${azurerm_storage_account.st-cicd.name}"
      storage_account_key  = "${azurerm_storage_account.st-cicd.primary_access_key}"
    }
  }

  tags {
    env = "tst"
  }
}
