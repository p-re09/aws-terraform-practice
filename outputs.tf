output "instance_public_ip" {
  description = "Public IP address assigned to the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket created for app storage"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "iam_role_name" {
  description = "IAM role attached to the EC2 instance"
  value       = aws_iam_role.ec2_role.name
}
