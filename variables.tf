variable "proyecto" {
  description = "Identificador del proyecto de Google Cloud"
  type        = string
}

variable "zona" {
  description = "Zona donde vive la máquina"
  type        = string
  default     = "us-central1-a"
}

variable "tipo_maquina" {
  description = "Tipo de máquina de Compute Engine"
  type        = string
  default     = "e2-micro"
}