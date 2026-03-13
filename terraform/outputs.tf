output "ec2_public_ip" {
  description = "The Public IP of the instance (Feed this to GitHub Actions)"
  value       = aws_instance.app_server.public_ip
}