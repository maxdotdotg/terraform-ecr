# using CPU-driven scaling module from TF registry
# https://registry.terraform.io/modules/cn-terraform/ecs-service-autoscaling/aws/latest

module "ecs-service-autoscaling" {
  source                    = "cn-terraform/ecs-service-autoscaling/aws"
  version                   = "1.0.3"
  ecs_cluster_name          = "${var.name}-cluster"
  ecs_service_name          = aws_ecs_service.service.name
  name_prefix               = var.name
  scale_target_min_capacity = var.desired_count
  max_cpu_threshold         = var.max_cpu_threshold
}

