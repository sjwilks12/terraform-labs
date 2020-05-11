variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "webapplocs" {
    description = "Web app locations"
    default     =   []
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}