data "aws_vpc" "lab_vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "ec2_sg" {
  name        = "lab-ec2-sg"
  description = "Security group for lab's EC2 instance"
  vpc_id      = data.aws_vpc.lab_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab-ec2-sg"
  }
}

data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
  EOF
}

resource "aws_instance" "web_server" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = true

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "lab-ec2-instance"
  }
}
