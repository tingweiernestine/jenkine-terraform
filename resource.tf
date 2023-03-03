# vpc creation
resource "aws_vpc" "prime-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "prime"
  }
}

# first public subnet
resource "aws_subnet" "prime-pub" {
  vpc_id            = aws_vpc.prime-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prime-pub"
  }
}

# Second public subnet

resource "aws_subnet" "prime-priv1" {
  vpc_id            = aws_vpc.prime-vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prime-priv"
  }
}

# private subnet

resource "aws_subnet" "prime-priv2" {
  vpc_id            = aws_vpc.prime-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "private-sub"
  }
}

# Internet gateway

resource "aws_internet_gateway" "prime-gw" {
  vpc_id = aws_vpc.prime-vpc.id

  tags = {
    Name = "prime-igw"
  }
}

# Public Route Table 

resource "aws_route_table" "prime-pub-rt" {
  vpc_id = aws_vpc.prime-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prime-gw.id
  }


  tags = {

    Name = "public-rt"
  }
}
# Private route table

resource "aws_route_table" "prime-priv-rt" {
  vpc_id = aws_vpc.prime-vpc.id

  route = []

  tags = {
    Name = "private-rt"
  }
}


# Subnet-pub1 association with routr table

resource "aws_route_table_association" "prime-pub" {
  subnet_id      = aws_subnet.prime-pub.id
  route_table_id = aws_route_table.prime-pub-rt.id
}

# Subnet-pub1 association with routr table

resource "aws_route_table_association" "prime-priv1" {
  subnet_id      = aws_subnet.prime-priv1.id
  route_table_id = aws_route_table.prime-priv-rt.id
}

# Subnet-pub1 association with routr table

resource "aws_route_table_association" "prime-priv2" {
  subnet_id      = aws_subnet.prime-priv2.id
  route_table_id = aws_route_table.prime-priv-rt.id
}