# 🗄️ AWS S3 Infrastructure with Terraform

Projeto simples para criar buckets S3 criptografados na AWS usando Terraform com state no S3.

## 🚀 Características

- **2 Buckets S3**: Principal e para logs
- **Criptografia**: AES256 em todos os buckets
- **Versionamento**: Habilitado para controle de versões
- **Logs de acesso**: Configurado automaticamente
- **Lifecycle rules**: Transição automática para IA e Glacier
- **Segurança**: Bloqueio de acesso público
- **Backend remoto**: tfstate armazenado no S3

## 📋 Buckets Criados

1. **Bucket Principal**: `storage-marcelo-dev-{random}`
   - Armazenamento principal de dados
   - Criptografia AES256
   - Versionamento habilitado
   - Lifecycle rules configuradas

2. **Bucket de Logs**: `storage-marcelo-logs-dev-{random}`
   - Logs de acesso do bucket principal
   - Criptografia AES256
   - Auto-limpeza após 90 dias

## 🛠️ Como usar

### Deploy via GitHub Actions
1. **Automático**: Push para `main` → Deploy automático
2. **Manual**: Actions → Deploy S3 → `apply`

### Deploy local
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Destroy
```bash
# Via GitHub Actions
Actions → Destroy S3 → Digite "DESTROY"

# Local
terraform destroy
```

## 📊 Outputs

Após o deploy, você terá:
- Nomes dos buckets
- ARNs dos buckets
- Informações de criptografia
- Resumo completo da infraestrutura

## 🔒 Segurança

- ✅ Criptografia AES256
- ✅ Bloqueio de acesso público
- ✅ Versionamento habilitado
- ✅ Logs de acesso
- ✅ State criptografado no S3