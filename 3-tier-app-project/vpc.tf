# vpc
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "project-vpc"
  }
}

### subnets ###
resource "aws_subnet" "pub-sub-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "public-subnet-1"
  }
}


resource "aws_subnet" "pub-sub-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-2"
  }
}
resource "aws_subnet" "fro-sub-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "frontend-subnet-1"
  }
}

resource "aws_subnet" "fro-sub-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "forntend-subnet-2"
  }
}

resource "aws_subnet" "back-sub-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "backend-subnet-1"
  }
}

resource "aws_subnet" "back-sub-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.5.0/24"
  tags = {
    Name = "backend-subnet-2"
  }
}

resource "aws_subnet" "rds-sub-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.6.0/24"
  tags = {
    Name = "rds-subnet-1"
  }
}

resource "aws_subnet" "rds-sub-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.7.0/24"
  tags = {
    Name = "rds-subnet-2"
  }
}

#### internet gateway ####
resource "aws_internet_gateway" "pro-ig" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "project-ig"
  }
}

### route tables ###
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "public-route"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pro-ig.id
  }
}

resource "aws_route_table_association" "rt-ass-1" {
  route_table_id =  aws_route_table.pub-rt.id
  subnet_id = aws_subnet.pub-sub-1.id

}

resource "aws_route_table_association" "rt-ass-2" {
  route_table_id =  aws_route_table.pub-rt.id
  subnet_id = aws_subnet.pub-sub-2.id
}

## eip ##
resource "aws_eip" "pro-eip" {
  domain = aws_vpc.my-vpc.id
}

### nat gateway ###  
resource "aws_nat_gateway" "pro-nat" {
  subnet_id = aws_subnet.pub-sub-1.id
  allocation_id = aws_eip.pro-eip.id
  tags = {
    Name = "project-nat" 
  }
}

### private route ###   
resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "private-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pro-nat.id
  }
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.fro-sub-1.id
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.fro-sub-2.id
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.back-sub-1.id
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.back-sub-2.id
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.rds-sub-1.id
}

resource "aws_route_table_association" "prt-ass-1" {
  route_table_id = aws_route_table.pri-rt.id
  subnet_id = aws_subnet.rds-sub-2.id
}



