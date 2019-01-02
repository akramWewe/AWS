resource "aws_iam_role" "config_role" {

  name = "${var.basename}-${var.deploy_env}awsconfig"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "config_role_policy" {

  name = "${var.basename}-awsconfig-policy"

  role = "${aws_iam_role.config_role.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${data.terraform_remote_state.trail-config-bucket.s3_bucket_arn}",
        "${data.terraform_remote_state.trail-config-bucket.s3_bucket_arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketLogging",
          "s3:GetBucketNotification",
          "s3:GetBucketPolicy",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketWebsite",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "${data.terraform_remote_state.trail-config-bucket.kms_bucket}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "managed_awsconfig_role_link" {

  role = "${aws_iam_role.config_role.name}"

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}