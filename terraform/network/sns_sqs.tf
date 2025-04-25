resource "aws_sns_topic" "video_start_processing" {
  name                        = "video-start-processing.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "processing_video_consumer" {
  name                        = "processing-video-consumer.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "notification_queue" {
  name                        = "notification-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "video_start_processing_subscription" {
  topic_arn            = aws_sns_topic.video_start_processing.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.processing_video_consumer.arn
  raw_message_delivery = true
}

resource "aws_sqs_queue_policy" "processing_video_consumer_policy" {
  queue_url = aws_sqs_queue.processing_video_consumer.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "SQS:SendMessage",
      Resource  = aws_sqs_queue.processing_video_consumer.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.video_start_processing.arn
        }
      }
    }]
  })
}
