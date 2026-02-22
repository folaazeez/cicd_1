output "ecr_repo_url" { value = aws_ecr_repository.policy_gate.repository_url }
output "cluster_name" { value = aws_ecs_cluster.main.name }
output "cluster_id" { value = aws_ecs_cluster.main.id }
output "subnet_id" { value = aws_subnet.public_a.id }
output "vpc_id" { value = aws_vpc.main.id }
output "ecs_tasks_sg" { value = aws_security_group.ecs_tasks.id }
output "aws_cloudwatch_log_group_name" {value = aws_cloudwatch_log_group.policy_gate.name}
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}