### security group ###     
resource "aws_security_group" "pro-sec" {
  vpc_id = aws_vpc.my-vpc.id
  name = "project-security"
  description = "allow ssh and http"
  depends_on = [ aws_vpc.my-vpc ]
  tags = {
    Name = "project-security"
  }
  
  ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

## alb frontend ##   
### security group ###     
resource "aws_security_group" "alb-frontend" {
  vpc_id = aws_vpc.my-vpc.id
  name = "alb-frontend"
  description = "allow inbound alb traffic"
  depends_on = [ aws_vpc.my-vpc ]
  tags = {
    Name = "alb-frontend"
  }
  
  ingress {
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

## alb backend ##
### security table ###     
resource "aws_security_group" "backend-alb" {
  vpc_id = aws_vpc.my-vpc.id
  name = "backend-alb"
  description = "allow inbound traffic alb"
  depends_on = [ aws_vpc.my-vpc ]
  tags = {
    Name = "backend-alb"
  }
  
  ingress {
    description = "allow https"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

## frontend 
### security group ###     
resource "aws_security_group" "front-ser" {
  vpc_id = aws_vpc.my-vpc.id
  name = "frontend-sg"
  description = "allow inbound traffic"
  depends_on = [ aws_vpc.my-vpc,aws_security_group.alb-frontend ]
  tags = {
    Name = "frontend-sg"
  }
  
  ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

## backend ##
### security group ###     
resource "aws_security_group" "back-ser" {
  vpc_id = aws_vpc.my-vpc.id
  name = "backend-sg"
  description = "allow inbound traffic"
  depends_on = [ aws_vpc.my-vpc,aws_security_group.backend-alb ]
  tags = {
    Name = "backend-sg"
  }
  
  ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "allow http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

## database ##  
### security group ###     
resource "aws_security_group" "rds-ser" {
  vpc_id = aws_vpc.my-vpc.id
  name = "rds-sg"
  description = "allow inbound"
  depends_on = [ aws_vpc.my-vpc ]
  tags = {
    Name = "rds-sg"
  }
  
  ingress {
    description = "mysql/aroura"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}