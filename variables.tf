variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "webapplocs" {
    description = "Web app locations"
    default     =   [ "eastus2", "uksouth", "centralindia" ]
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}