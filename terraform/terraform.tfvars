# ======================
# VALORES DAS VARIÁVEIS
# ======================

# Projeto
project_name = "storage-marcelo"
environment  = "dev"

# AWS
aws_region = "us-east-1"

# Configurações dos buckets
enable_versioning     = true
enable_encryption     = true
enable_access_logging = true
lifecycle_enabled     = true

# Ciclo de vida (em dias)
days_to_ia      = 30   # Transição para Infrequent Access
days_to_glacier = 90   # Transição para Glacier
days_to_expire  = 365  # Expiração dos objetos