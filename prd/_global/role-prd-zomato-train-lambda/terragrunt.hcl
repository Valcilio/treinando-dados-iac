include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/iam_role.hcl"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env      = local.env_vars.locals.environment

  name = "zomato-train-lambda"
}

inputs = {
  role_name = "role-${local.env}-${local.name}"
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
          "s3:*",
          "s3-object-lambda:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "EC2FullAccess"
        Action = [
          "ec2:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "IAMFullAccess"
        Action = [
          "iam:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}