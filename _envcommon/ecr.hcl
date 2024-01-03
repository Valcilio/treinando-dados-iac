terraform {
  source = "git::git@github.com:Valcilio/terraform_blueprints.git//ecr?ref=main"
}

locals {
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    region = local.region_vars.locals.region
}

inputs = {
    aws_region = local.region
}