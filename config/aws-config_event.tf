resource "aws_cloudwatch_event_rule" "config_resource_change_event" {
  name        = "config-ressource-change-events"
  description = "Get notifications when a resource in your account changes."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.config"
  ],
  "detail-type": [
    "Config Configuration Item Change"
  ]
}
PATTERN
}


resource "aws_cloudwatch_event_target" "config_resource_check_alerting" {
  target_id = "resource_check_target"
  arn       = "${data.terraform_remote_state.sns_mail.arn}"
  rule      = "${aws_cloudwatch_event_rule.config_resource_change_event.name}"
}

resource "aws_cloudwatch_event_rule" "config_compliance_check_fail_event" {
  name        = "config-compliance-check-fail-event"
  description = "Get notifications when a compliance check to your rules fails."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.config"
  ],
  "detail-type": [
    "Config Rules Compliance Change"
  ]
}
PATTERN
}


resource "aws_cloudwatch_event_target" "config_compliance_check_alerting" {
  target_id = "compliance_check_target"
  arn       = "${data.terraform_remote_state.sns_mail.arn}"
  rule      = "${aws_cloudwatch_event_rule.config_compliance_check_fail_event.name}"
}

resource "aws_cloudwatch_event_rule" "config_history_delivery_check_event" {
  name        = "config-history-delivery-check-event"
  description = "Get configuration history delivery status notifications."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.config"
  ],
  "detail-type": [
    "Config Configuration History Delivery Status"
  ]
}
PATTERN
}


resource "aws_cloudwatch_event_target" "config_history_delivery_alerting" {
  target_id = "compliance_check_target"
  arn       = "${data.terraform_remote_state.sns_mail.arn}"
  rule      = "${aws_cloudwatch_event_rule.config_history_delivery_check_event.name}"
}

resource "aws_cloudwatch_event_rule" "config_re_evaluate_check_event" {
  name        = "config-re-evaluate-check-event"
  description = "Get reevaluation status notifications.."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.config"
  ],
  "detail-type": [
    "Config Rules Re-evaluation Status"
  ]
}
PATTERN
}


resource "aws_cloudwatch_event_target" "config_re_evaluate_alerting" {
  target_id = "re_evaluate_config_target"
  arn       = "${data.terraform_remote_state.sns_mail.arn}"
  rule      = "${aws_cloudwatch_event_rule.config_history_delivery_check_event.name}"
}