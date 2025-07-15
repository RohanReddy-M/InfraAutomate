output "public_ip" {
  value = aws_instance.uptime_instance.public_ip
}

output "ssh_command" {
  value = "ssh -i C:/Users/machi/SecureShip/key.pem ubuntu@${aws_instance.uptime_instance.public_ip}"
}
