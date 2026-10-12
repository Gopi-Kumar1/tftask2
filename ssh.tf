locals {
  tags = {
    Project = var.project
    ID      = var.task_id
  }
}

resource "aws_key_pair" "this" {
  key_name   = "${var.task_id}-keypair"
  public_key = var.ssh_key

  tags = merge(local.tags, {
    Name = "${var.task_id}-keypair"
  })
}