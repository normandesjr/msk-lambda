module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "iti-zup"
  cidr = "192.168.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24"]
  public_subnets  = ["192.168.10.0/24", "192.168.20.0/24"]

  enable_nat_gateway = true

  tags = {
    Name = "iti-zup"
  }

  private_subnet_tags = {
    Name = "iti-zup-private"
  }

  public_subnet_tags = {
    Name = "iti-zup-public"
  }

  public_route_table_tags = {
    Name = "iti-zup-public-route"
  }

  private_route_table_tags = {
    Name = "iti-zup-private-route"
  }
}