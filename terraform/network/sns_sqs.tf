resource "aws_sns_topic" "processor_topic" {
  name = "processor-topic"
}

resource "aws_sqs_queue" "processor_queue" {
  name                        = "processor-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "processor_subscription" {
  topic_arn = aws_sns_topic.processor_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.processor_queue.arn
  raw_message_delivery = true
}

resource "aws_sqs_queue_policy" "processor_policy" {
  queue_url = aws_sqs_queue.processor_queue.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "SQS:SendMessage",
      Resource  = aws_sqs_queue.processor_queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.processor_topic.arn
        }
      }
    }]
  })
}
