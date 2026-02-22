resource "aws_ecs_task_definition" "policy_gate" {
  family                   = "policy-gate"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  # This execution role should live in foundation (recommended).
  # If it currently lives in foundation, output it and reference it here.
  execution_role_arn = data.terraform_remote_state.foundation.outputs.ecs_task_execution_role_arn

  container_definitions = jsonencode([{
    name      = "policy-gate"
    image     = var.policy_gate_image
    essential = true
    environment = [
      {
        name  = "ENVIRONMENT",
        value = var.environment
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = data.terraform_remote_state.foundation.outputs.aws_cloudwatch_log_group_name
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "policy_gate" {
  name            = "policy-gate"
  cluster         = data.terraform_remote_state.foundation.outputs.cluster_id
  task_definition = aws_ecs_task_definition.policy_gate.arn
  desired_count   = var.replica_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [data.terraform_remote_state.foundation.outputs.subnet_id]
    security_groups  = [data.terraform_remote_state.foundation.outputs.ecs_tasks_sg]
    assign_public_ip = true
  }
}