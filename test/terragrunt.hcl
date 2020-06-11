locals {
  ## !!!CHANGE ME!!! ##
  application = "skeleton"
  repo        = "terraform-module-skeleton"
  repo_path   = "test"
  owner       = "devops@opploans.com"

  environment = "poc1"
  account     = "sandbox1"
  aws_region  = "us-east-1"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "iac-remote-state-opploans-${local.account}"
    key            = "${local.environment}/module-test/${local.application}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "iac-remote-state-lock-opploans-${local.account}"
    profile        = local.account
  }
}

terraform {
  source = "../"

  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=5m"]
  }
}

inputs = {
  application = local.application
  environment = local.environment
  aws_region  = local.aws_region
  repo        = local.repo
  repo_path   = local.repo_path
  aws_profile = local.account
  owner       = local.owner
}
