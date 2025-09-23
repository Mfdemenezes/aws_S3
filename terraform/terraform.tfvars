# ======================
# VALORES DAS VARI�VEIS
# ======================

# Projeto
project_name = "storage-marcelo"
environment  = "dev"

# AWS
aws_region = "us-east-1"

# Configura��es dos buckets
enable_versioning     = true
enable_encryption     = true
lifecycle_enabled     = true

# Ciclo de vida (em dias)
days_to_ia      = 30   # Transi��o para Infrequent Access
days_to_glacier = 90   # Transi��o para Glacier
days_to_expire  = 365  # Expira��o dos objetos