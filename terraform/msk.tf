resource "aws_msk_cluster" "cluster" {
  cluster_name           = "iti-zup-cluster"
  kafka_version          = "2.2.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type  = "kafka.t3.small"
    ebs_volume_size = 1
    client_subnets = module.vpc.private_subnets
    security_groups = [ aws_security_group.allow-all.id ]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
    }
  }
}

output "bootstrap_brokers" {
  description = "Cluster Kafka"
  value       = aws_msk_cluster.cluster.bootstrap_brokers
}
