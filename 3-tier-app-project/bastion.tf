resource "aws_instance" "pub" {
  ami = var.ami_id
  instance_type = var.instance-typr
  tags = {
    Name = "bastion"
  }
  key_name = var.key_name   
  subnet_id = aws_subnet.pub-sub-1.id
  vpc_security_group_ids = [ aws_security_group.pro-sec.id ]
  
}