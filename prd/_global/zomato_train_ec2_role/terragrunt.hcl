include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/iam_role_with_instance_profile.hcl"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env      = local.env_vars.locals.environment

  name = "zomato_train_ec2_role"
}

inputs = {
  role_name = "ecr-${local.env}-${local.name}"
  policy_permissions = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "CloudWatchFullAccess"
        Action = [
          "autoscaling:Describe*",
          "cloudwatch:*",
          "logs:*",
          "sns:*",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "oam:ListSinks"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "S3FullAccess"
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "ECRFullAccess"
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}