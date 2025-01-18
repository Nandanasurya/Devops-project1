provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-092015a0c1a544655"
}

data "aws_subnet" "existing_subnet" {
  id = "subnet-0002f28b4fa44695c"
}

data "aws_security_group" "existing_sg" {
  id = "sg-024e26467cf300d1c"
}

resource "aws_instance" "docker_instance" {
  ami                     = "ami-0d2614eafc1b0e4d2"
  instance_type           = "t2.micro"
  subnet_id               = data.aws_subnet.existing_subnet.id
  vpc_security_group_ids  = [data.aws_security_group.existing_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
               yum update -y
              amazon-linux-extras enable docker
              yum install docker -y
              service docker start
              usermod -a -G docker ec2-user
              EOF


  tags = {
    Name = "EC2Instance"
  }

  # Add your SSH key pair name here if needed
  key_name = "project1_key"  # Uncomment and add your SSH key pair name if you want to use it
}

output "instance_public_ip" {
  value       = aws_instance.docker_instance.public_ip
  description = "The public IP of the EC2 instance"
}


