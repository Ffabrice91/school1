provider "aws" {
  region = "us-east-1"
}

resource "aws_lightsail_instance" "lightsail" {
  name              = "lightsail_instance"
  availability_zone = "us-east-1a"
  blueprint_id      = "centos_7_2009_01"
  bundle_id         = "medium_2_0"
  key_pair_name     = "logkey"

  user_data = <<-EOF
#!/bin/bash 
    sudo yum update -y 
    sudo yum install unzip wget httpd -y  ( apt install wget unzip -y )
    sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
    sudo unzip main.zip
    sudo cp -r static-resume-main/* /var/www/html/  
    sudo systemctl start httpd
    sudo systemctl enable httpd
EOF
}


output "CentOS_public_ip" {
  value = aws_lightsail_instance.lightsail.public_ip_address
}

