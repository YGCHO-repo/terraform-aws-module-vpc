# Default Security Group ~> Any Open SG
resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.this.id

  ingress {
    description = "Default SG ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    self = false
  }

  egress {
    description = "Default SG Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, tomap({ Name = format("%s-%s-default-sg", var.prefix, var.vpc_name) }))
}

# ++++++++++++++++++++++++++++++++++++++++++
#    SG rule 생성시 Default role value
# ++++++++++++++++++++++++++++++++++++++++++
# Type의 경우! ingress or egress 가 있다.

#  Type = [ {           
#         cidr_blocks = [ "value" ]
#         description = "value"
#         from_port = 1
#         ipv6_cidr_blocks = [ "value" ]
#         prefix_list_ids = [ "value" ]
#         protocol = "value"
#         security_groups = [ "value" ]
#         self = false
#         to_port = 1
#     } ]