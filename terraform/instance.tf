resource "aws_instance" "instances" {
  ami = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"

  subnet_id = module.vpc.public_subnets[0]

  key_name = "terraform"

  vpc_security_group_ids = [ aws_security_group.allow-all.id ]

  user_data = templatefile("${path.module}/user_data/prepare_instance.tmpl", {bootstrap_servers = aws_msk_cluster.cluster.bootstrap_brokers})

}

output "instances" {
  value = aws_instance.instances.public_ip
}