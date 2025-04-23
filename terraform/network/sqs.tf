resource "aws_sqs_queue" "notification_queue" {
  name                        = "notification-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "processor_queue" {
  name                        = "processor-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}