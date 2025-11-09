data "aws_ami" "img1" {
  most_recent = true
  owners = [self]
  filter {
    name = "name"
    values = ["frontend-ami"]
  }
}

resource "aws_launch_template" "frontend" {
  name = "frontend-lt"  
  description = "frontend-lt"
  image_id = data.aws_ami.img1.id 
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.front-ser.id]
  key_name = "pro-key"   
  update_default_version = true 
  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "frontend-lt"
    }
  }   
}
data "aws_ami" "img2" {
  most_recent = true
  owners = [self]

filter {
  name = "name"
  values = ["backend-ami"]
}
}

resource "aws_launch_template" "backend" {
  name = "backend-lt"
  description = "backend-lt"
  image_id = data.aws_ami.img2.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.pro-sec,]
  key_name = "pro-key"
  update_default_version = true
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "backend-lt"
    }
  }
}