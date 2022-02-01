resource aws_subnet primary_subnet {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.default-availability-zone

  tags = {
    Name = "main subnet"
  }
}

resource aws_subnet secondary_subnet {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.default-availability-zone

  tags = {
    Name = "secondary subnet"
  }
}

resource aws_default_route_table primary_route_table {
  default_route_table_id = aws_vpc.primary_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_igateway.id
  }
}

resource aws_main_route_table_association primary-subnet-association {
  vpc_id = aws_vpc.primary_vpc.id
  route_table_id = aws_default_route_table.primary_route_table.id
}

resource aws_main_route_table_association secondary-subnet-association {
  vpc_id = aws_vpc.primary_vpc.id
  route_table_id = aws_default_route_table.primary_route_table.id
}
