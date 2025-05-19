resource "aws_api_gateway_vpc_link" "vpc_link_order" {
  name        = "fast-food-nlb-order"
  description = "VPC Link para conectar o API GTW ao NLB"
  target_arns = [data.aws_lb.nlb_order.arn]
}

resource "aws_api_gateway_vpc_link" "vpc_link_customer" {
  name        = "fast-food-nlb-customer"
  description = "VPC Link para conectar o API GTW ao NLB"
  target_arns = [data.aws_lb.nlb_customer.arn]
}

resource "aws_api_gateway_vpc_link" "vpc_link_payment" {
  name        = "fast-food-nlb-payment"
  description = "VPC Link para conectar o API GTW ao NLB"
  target_arns = [data.aws_lb.nlb_payment.arn]
}