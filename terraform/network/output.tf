output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.cluster_vpc.id
}

output "vpc_cidr_block" {
  description = "ID da VPC criada"
  value       = aws_vpc.cluster_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = [
    aws_subnet.public_cluster_subnet_1.id,
    aws_subnet.public_cluster_subnet_2.id
  ]
}

output "public_route_table_id" {
  description = "ID da tabela de rotas pública"
  value       = aws_route_table.public_cluster_route_table.id
}

output "aws_security_group_id" {
  description = "ID do Security Group"
  value       = aws_security_group.allow_tls.id
}

output "aws_internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.gw.id
}
