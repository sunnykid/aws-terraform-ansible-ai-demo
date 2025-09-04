provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_security_group" "msa_sg" {
  name        = "msa-sg"
  description = "Allow SSH and HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ai" {
  ami           = "ami-0e6c43c67db18194b"
  instance_type = "t3.micro"
  key_name      = "kyt-awskey"
  security_groups = [aws_security_group.msa_sg.name]
  tags = { Name = "AI-Server" }
}

resource "aws_instance" "app" {
  ami           = "ami-0e6c43c67db18194b"
  instance_type = "t3.micro"
  key_name      = "kyt-awskey"
  security_groups = [aws_security_group.msa_sg.name]
  tags = { Name = "App-Server" }
}

resource "aws_instance" "db" {
  ami           = "ami-0e6c43c67db18194b"
  instance_type = "t3.micro"
  key_name      = "kyt-awskey"
  security_groups = [aws_security_group.msa_sg.name]
  tags = { Name = "DB-Server" }
}
