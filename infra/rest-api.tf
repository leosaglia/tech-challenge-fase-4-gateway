data "aws_cognito_user_pool" "user_pool" {
  user_pool_id = "us-east-1_XajoTevCM"
}

data "template_file" "api_template" {
  template = file("${path.module}/openapi/fast-food-tech-challenge-definition.json")

  vars = {
    vpc_link_order_base_url = "http://${data.aws_lb.nlb_order.dns_name}:3001"
    vpc_link_order_id       = aws_api_gateway_vpc_link.vpc_link_order.id
    vpc_link_customer_base_url = "http://${data.aws_lb.nlb_customer.dns_name}:3001"
    vpc_link_customer_id       = aws_api_gateway_vpc_link.vpc_link_customer.id
    vpc_link_payment_base_url = "http://${data.aws_lb.nlb_payment.dns_name}:3001"
    vpc_link_payment_id       = aws_api_gateway_vpc_link.vpc_link_payment.id
  }
}

resource "aws_api_gateway_rest_api" "api" {
  name = "fast-food-tech-challenge"
  description = "API for Fast Food Tech Challenge"

  body = data.template_file.api_template.rendered
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ aws_api_gateway_rest_api.api ]
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "prod"

  depends_on = [ aws_api_gateway_deployment.deployment ]
}