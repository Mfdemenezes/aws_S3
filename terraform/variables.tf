# ======================
# VARIÁVEIS DO PROJETO S3
# ======================

variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto para prefixar recursos"
  type        = string
  default     = "meu-projeto-s3"
}

variable "environment" {
  description = "Ambiente de deployment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment deve ser: dev, staging ou prod."
  }
}

variable "enable_versioning" {
  description = "Habilitar versionamento nos buckets"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Habilitar criptografia nos buckets"
  type        = bool
  default     = true
}

variable "enable_access_logging" {
  description = "Habilitar logs de acesso"
  type        = bool
  default     = true
}

variable "lifecycle_enabled" {
  description = "Habilitar regras de ciclo de vida"
  type        = bool
  default     = true
}

variable "days_to_ia" {
  description = "Dias para transição para IA"
  type        = number
  default     = 30
}

variable "days_to_glacier" {
  description = "Dias para transição para Glacier"
  type        = number
  default     = 90
}

variable "days_to_expire" {
  description = "Dias para expiração dos objetos"
  type        = number
  default     = 365
}