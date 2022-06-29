resource "aws_internet_gateway" "this" {
    vpc_id = var.enable_internet_gateway == "ture" ? aws_vpc.this.id : ""
    
    tags = merge(var.tags, tomap({Name = format("%s-%s-igw", var.prefix, var.vpc_name)})) 
}
