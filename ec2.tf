data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["${var.task_id}-vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

data "aws_subnet" "public" {
  id = data.aws_subnets.public.ids[0]
}

data "aws_security_group" "ssh" {
  vpc_id = data.aws_vpc.existing.id

  filter {
    name   = "group-name"
    values = ["${var.task_id}-sg"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [data.aws_security_group.ssh.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  tags = merge(local.tags, {
    Name = "${var.task_id}-ec2"
  })
}

