resource "aws_ecs_service" "service" {
  name                   = "${var.name}-service"
  cluster                = aws_ecs_cluster.cluster.id
  task_definition        = aws_ecs_task_definition.task.arn
  desired_count          = var.desired_count
  launch_type            = "FARGATE"
  platform_version       = "1.4.0"
  enable_execute_command = "true"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.name
    container_port   = var.container_port
  }

  # Allow changes via autoscaling without appearing in Terraform plan diff
  lifecycle {
    ignore_changes = [desired_count]
  }
}

