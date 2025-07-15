provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "infra_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "infra_gw" {
  vpc_id = aws_vpc.infra_vpc.id
}

resource "aws_subnet" "infra_subnet" {
  vpc_id                  = aws_vpc.infra_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "infra_rt" {
  vpc_id = aws_vpc.infra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra_gw.id
  }
}

resource "aws_route_table_association" "infra_rta" {
  subnet_id      = aws_subnet.infra_subnet.id
  route_table_id = aws_route_table.infra_rt.id
}

resource "aws_security_group" "infra_sg" {
  name        = "infra_sg"
  description = "Allow SSH and app ports"
  vpc_id      = aws_vpc.infra_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 3001
    to_port     = 3001
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

resource "aws_key_pair" "rohan_key" {
  key_name   = "rohan-key"
  public_key = file("C:/Users/machi/SecureShip/key.pub")
}

resource "aws_instance" "uptime_instance" {
  ami           = "ami-0f58b397bc5c1f2e8" # Ubuntu 22.04 LTS (ap-south-1)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.rohan_key.key_name
  subnet_id     = aws_subnet.infra_subnet.id
  vpc_security_group_ids = [aws_security_group.infra_sg.id]

  tags = {
    Name = "infra-uptime-instance"
  }
}
