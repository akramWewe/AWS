resource "aws_config_config_rule" "tag_compliance" {

  name = "tag-compliance"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = <<EOF
{
  "tag1Key":"Name"
}
EOF

  scope {
    compliance_resource_types = [
      "AWS::EC2::Instance",
      "AWS::RDS::DBInstance",
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "ec2-volume-inuse-check" {

  name = "ec2-volume-inuse-check"

  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }

  scope {
    compliance_resource_types = [
      "AWS::EC2::Volume",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "restricted-ssh" {

  name = "restricted-ssh"

  description = "Checks whether security groups in use do not allow restricted incoming SSH traffic."

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "instances-in-vpc" {
  name        = "instances-in-vpc"
  description = "Ensure all EC2 instances run in a VPC"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "eip-attached" {
  name        = "eip-attached"
  description = "Checks whether all Elastic IP addresses that are allocated to a VPC are attached to EC2 instances or in-use elastic network interfaces (ENIs)."

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "cloudtrail-enabled" {
  name        = "cloudtrail-enabled"
  description = "Ensure CloudTrail is enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  maximum_execution_frequency = "One_Hour"
  depends_on = ["aws_config_configuration_recorder.config_recorder"]

}

resource "aws_config_config_rule" "s3-bucket-versioning-enabled" {
  name        = "s3-bucket-versioning-enabled"
  description = "Ensure s3 buckets have versionning enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

    scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "s3-bucket-server-side-encryption-enabled" {
  name        = "s3-bucket-server-side-encryption-enabled"
  description = "Checks whether the S3 bucket policy denies the put-object requests that are not encrypted using AES-256 or AWS KMS."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

    scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "s3-bucket-public-write-prohibited" {
  name        = "s3-bucket-public-write-prohibited"
  description = "Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

    scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "s3-bucket-public-read-prohibited" {
  name        = "s3-bucket-public-read-prohibited"
  description = "Checks that your S3 buckets do not allow public read access. If an S3 bucket policy or bucket ACL allows public read access, the bucket is noncompliant."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

    scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "restricted-common-ports" {
  name        = "restricted-common-ports"
  description = "Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
  input_parameters = <<EOF
{
  "blockedPort1":"80",
  "blockedPort2":"8080",
  "blockedPort3":"20",
  "blockedPort4":"21",
  "blockedPort5":"3306"
}
EOF

  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }

    scope {
    compliance_resource_types = [
      "AWS::EC2::SecurityGroup",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "rds-storage-encrypted" {
  name        = "rds-storage-encrypted"
  description = "Checks whether storage encryption is enabled for your RDS DB instances."

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }

    scope {
    compliance_resource_types = [
      "AWS::RDS::DBInstance",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "rds-instance-public-access-check" {
  name        = "rds-instance-public-access-check"
  description = "Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible. The rule is non-compliant if the publiclyAccessible field is true in the instance configuration item."

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }

    scope {
    compliance_resource_types = [
      "AWS::RDS::DBInstance",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "rds-multi-az-support" {
  name        = "rds-multi-az-support"
  description = "Checks whether high availability is enabled for your RDS DB instances."

  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }

    scope {
    compliance_resource_types = [
      "AWS::RDS::DBInstance",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "lambda-function-public-access-prohibited" {
  name        = "lambda-function-public-access-prohibited"
  description = "Checks whether the Lambda function policy prohibits public access. The rule is NON_COMPLIANT if the Lambda function policy allows public access."

  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED"
  }

    scope {
    compliance_resource_types = [
      "AWS::Lambda::Function",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "db-instance-backup-enabled" {
  name        = "rdb-instance-backup-enabled"
  description = "Checks whether RDS DB instances have backups enabled. Optionally, the rule checks the backup retention period and the backup window."
  input_parameters = <<EOF
{
  "backupRetentionPeriod":"30"
}
EOF

  source {
    owner             = "AWS"
    source_identifier = "DB_INSTANCE_BACKUP_ENABLED"
  }

    scope {
    compliance_resource_types = [
      "AWS::RDS::DBInstance",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_config_rule" "approved-amis-by-tag" {
  name        = "approved-amis-by-tag"
  description = "Checks whether running instances are using specified AMIs. Specify the tags that identify the AMIs. Running instances with AMIs that don't have at least one of the specified tags are noncompliant."
  input_parameters = <<EOF
{
  "amisByTagKeyAndValue":"Name:app-Image"
}
EOF

  source {
    owner             = "AWS"
    source_identifier = "APPROVED_AMIS_BY_TAG"
  }

    scope {
    compliance_resource_types = [
      "AWS::EC2::Instance"
    ]
  }
  depends_on = ["aws_config_configuration_recorder.config_recorder"]
}

resource "aws_config_configuration_recorder" "config_recorder" {

  name = "${var.basename}"

  recording_group {
    include_global_resource_types = true
  }

  role_arn = "${aws_iam_role.config_role.arn}"
}

