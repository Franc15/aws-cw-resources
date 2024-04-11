#!/bin/bash
yum update -y
yum install python3-pip -y
pip3 install boto3
mkdir /home/ec2-user/Pictures/
cd /home/ec2-user/Pictures/
wget https://github.com/Atorudibo-Seth1/images/raw/main/image1.jpg https://github.com/Atorudibo-Seth1/images/raw/main/image2.jpg https://github.com/Atorudibo-Seth1/images/raw/main/image3.jpg https://github.com/Atorudibo-Seth1/images/raw/main/image4.jpg https://github.com/Atorudibo-Seth1/images/raw/main/image5.jpg

echo "import boto3
import os
import time

# Setting up and initializing Boto3 S3 client
s3_client = boto3.client('s3')

# Setting up a directory for the images path and bucket name
image_path = '/home/ec2-user/Pictures/'
bucket_name = 'bucket-s2110844'
    
sqs = boto3.client('sqs')

# Creating the queue. This returns an SQS Queue instance
queue = sqs.create_queue(QueueName='myQueueS2110844', 
                         Attributes={
                             'DelaySeconds': '5',
                             'MessageRetentionPeriod': '86400'
                             })

queue_url = sqs.get_queue_url(
    QueueName = 'myQueueS2110844'
)

# You can now access identifiers and attributes
print(queue_url)
print(queue_url['QueueUrl'])

# queue_url = 'https://sqs.us-east-1.amazonaws.com/497350859733/myQueueS1935074'    

# Looping through the image files in directory as uploading them to the bucket
for images in os.listdir(image_path):
    if images.endswith('.jpg'):
        upload_file_key = 'images/' + str(images)
        # Upload images file to the S3 bucket
        with open(os.path.join(image_path, images), 'rb') as h:
            s3_client.upload_fileobj(h, bucket_name, upload_file_key)
            sqs.send_message(QueueUrl=queue_url, MessageBody='Image upload to Bucket s3bucket-s1935074 was successful')
            time.sleep(30)" > /home/ec2-user/bucket.py
    
chmod 744 /home/ec2-user/bucket.py
