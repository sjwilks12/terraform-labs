module "scaffold" {
  source    = "github.com/sjwilks12/terraform-module-scaffold"
}

resource "azurerm_resource_group" "webapps" {
   name         = "webapps"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    count               = "${length(var.webapplocs)}"
    name                = "plan-std-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "citadel" {
    count               = "${length(var.webapplocs)}"
    name                = "webapp-${random_string.webapprnd.result}-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    app_service_plan_id = "${element(azurerm_app_service_plan.free.*.id, count.index)}"
}

output "webapp_ids" {
  value = "${azurerm_app_service.citadel.*.id}"
}