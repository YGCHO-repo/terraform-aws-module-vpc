# ++++++++++++++++++++++++++++++++++++++++++++
#                  Route table 
# ++++++++++++++++++++++++++++++++++++++++++++

# Dynamic route table for public
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
  for_each = { for i in local.public_subnets : i.cidr => i }

    # Dynamic block
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
    
    tags = merge(var.tags,
        tomap({
            Name = format(
                "%s-%s-%s-%s-%s-rtb",
                var.prefix,
                var.vpc_name,
                var.azs[index(var.subnets[each.value.name].cidr, each.key)],
                var.subnets[each.value.name].ipv4_type,
                each.value.name
            )
        }),
        { "Tier" = "public" }
    )
}

# Dynamic route table for private with nat gateway
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id
    for_each = { for i in local.private_subnets : i.cidr => i if i.rt2natgw == "no" }
    
    tags = merge(var.tags,
        tomap({
            Name = format(
                "%s-%s-%s-%s-%s-rtb",
                var.prefix,
                var.vpc_name,
                var.azs[index(var.subnets[each.value.name].cidr, each.key)],
                var.subnets[each.value.name].ipv4_type,
                each.value.name
            )
        }),
        { "Tier" = "private" }
    )
}

# dynamic route table for private with nat gateway
resource "aws_route_table" "private_with_natgw" {
  vpc_id = aws_vpc.this.id
  for_each = { for i in local.private_subnets : i.cidr => i if i.rt2natgw == "yes" }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.this[element(var.subnets["natgw"].cidr, index(var.subnets[each.value.name].cidr, each.key))].id}"
    
  }

  tags = merge(var.tags,
    tomap({
      Name = format(
        "%s-%s-%s-%s-%s-rt",
        var.prefix,
        var.vpc_name,
        var.azs[index(var.subnets[each.value.name].cidr, each.key)],
        var.subnets[each.value.name].ipv4_type,
        each.value.name
      )
    }),
    { "Tier" = "private" }
  )
}


# ++++++++++++++++++++++++++++++++++++++++++++
#           Route table association
# ++++++++++++++++++++++++++++++++++++++++++++

# Public route table association
resource "aws_route_table_association" "public" {
    for_each = { for i in local.public_subnets : i.cidr => i }

    subnet_id = aws_subnet.this[each.key].id
    route_table_id = aws_route_table.public[each.key].id
}

# Private route table association
resource "aws_route_table_association" "private" {
    for_each = { for i in local.private_subnets : i.cidr => i if i.rt2natgw == "no" }

    subnet_id = aws_subnet.this[each.key].id
    route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route_table_association" "private_natgw" {
    for_each = { for i in local.private_subnets : i.cidr => i if i.rt2natgw == "yes" }

    subnet_id = aws_subnet.this[each.key].id
    route_table_id = aws_route_table.private_with_natgw[each.key].id
}