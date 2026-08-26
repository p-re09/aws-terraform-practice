# AWS Infrastructure with Terraform

A small piece of AWS infrastructure provisioned entirely through Terraform,
with a GitHub Actions pipeline that validates every change automatically
and gates real deployment behind a manual trigger.

## What this provisions

- **EC2 instance** (`t3.micro`) running a Python Flask app, deployed
  automatically via a `user_data` startup script.
- **S3 bucket** for application storage, with public access explicitly
  blocked at the bucket level.
- **IAM role**, scoped so the EC2 instance can only read and write to that
  one S3 bucket — not a wildcard admin role.
- **Security group** restricting SSH access to a single IP address, while
  leaving HTTP open so the deployed app is reachable.

## Why it's built this way

- **Least-privilege IAM.** The instance's role grants exactly the
  permissions it needs (`s3:PutObject`, `s3:GetObject`, `s3:ListBucket`
  on one bucket) and nothing more.
- **Infrastructure as code, not console clicks.** Every resource is
  defined in `.tf` files, so the entire environment can be rebuilt or torn
  down from a clean state with `terraform apply` / `terraform destroy`.
- **CI validates, humans deploy.** GitHub Actions runs `fmt`, `init`, and
  `validate` on every push automatically. `apply` and `destroy` are never
  triggered by a push — they require a manual `workflow_dispatch` action,
  so infrastructure changes are never applied unattended.

## Structure

| File | Purpose |
|---|---|
| `main.tf` | Provider config and all AWS resources (EC2, S3, IAM, security group) |
| `variables.tf` | Input variables (region, key pair name, allowed SSH IP, AMI ID) |
| `outputs.tf` | Prints the instance's public IP, bucket name, and IAM role name after apply |
| `.github/workflows/terraform.yml` | CI/CD pipeline: automatic validation on push, manual-triggered apply/destroy |
| `.gitignore` | Excludes Terraform state files and SSH keys from version control |

## Running it

```bash
terraform init
terraform plan -var="key_pair_name=<your-key-pair>" -var="my_ip_cidr=<your-ip>/32"
terraform apply -var="key_pair_name=<your-key-pair>" -var="my_ip_cidr=<your-ip>/32"
```

Requires an AWS account with credentials configured (`aws configure`), an
existing EC2 key pair, and Terraform installed locally.

After `apply`, the instance's public IP is printed as an output —
visiting it in a browser confirms the deployed app is running. Tear
everything down with:

```bash
terraform destroy -var="key_pair_name=<your-key-pair>" -var="my_ip_cidr=<your-ip>/32"
```

## Verified

- Deployed application reachable over HTTP at the provisioned instance's
  public IP.
- Connected via SSH to the running Amazon Linux 2023 instance to confirm
  the Flask process was active and check disk usage directly.
