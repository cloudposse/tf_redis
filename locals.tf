locals {
  common_tags = {
    Name        = local.resource_name
    Environment = var.environment
    Application = var.application
    Owner       = var.owner
    Repo        = var.repo
    RepoPath    = var.repo_path
    Tool        = "terraform"
  }

  tags          = merge(local.common_tags, var.additional_tags)
  resource_name = format("%s-%s", var.environment, var.application)
  elasticache_subnet_group_name = coalesce(var.elasticache_subnet_group_name, join("", aws_elasticache_subnet_group.default.*.name))

}