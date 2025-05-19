data "aws_lb" "nlb_order" {
  tags = {
    "kubernetes.io/service-name" = "default/tech-challenge-fase-4-order-api-service"
  }
}

data "aws_lb" "nlb_customer" {
  tags = {
    "kubernetes.io/service-name" = "default/tech-challenge-fase-4-customer-api-service"
  }
}

data "aws_lb" "nlb_payment" {
  tags = {
    "kubernetes.io/service-name" = "default/tech-challenge-fase-4-payment-api-service"
  }
}

data "aws_iam_role" "role" {
  name = "LabRole"
}
