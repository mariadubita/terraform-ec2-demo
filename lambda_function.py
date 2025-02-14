import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    ec2_client = boto3.client('ec2')
    s3_client = boto3.client('s3')
    
    instance_id = os.environ['INSTANCE_ID']
    bucket_name = os.environ['S3_BUCKET']
    
    response = ec2_client.describe_instances(InstanceIds=[instance_id])
    state = response['Reservations'][0]['Instances'][0]['State']['Name']
    
    log_data = f"Instance {instance_id} is in state: {state} at {datetime.utcnow().isoformat()}"
    
    filename = f"logs/{instance_id}-{datetime.utcnow().timestamp()}.log"
    s3_client.put_object(
        Bucket=bucket_name,
        Key=filename,
        Body=log_data.encode('utf-8')
    )
    
    return {"message": log_data}
