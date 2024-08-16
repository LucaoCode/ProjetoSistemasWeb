from diagrams import Diagram, Cluster
from diagrams.aws.compute import EC2, Lambda
from diagrams.aws.database import RDS
from diagrams.aws.network import APIGateway
from diagrams.aws.storage import S3
from diagrams.aws.management import Cloudwatch
from diagrams.aws.integration import SNS
from diagrams.generic.device import Mobile

with Diagram("Expanded Pet Shop Architecture", show=False):
    # Client
    mobile = Mobile("Mobile Client")

    # Frontend
    with Cluster("Frontend"):
        s3 = S3("S3 Bucket")

    # Backend
    with Cluster("Backend"):
        ec2 = EC2("EC2 Instance")

        # Adding Lambda Functions
        with Cluster("Lambda Functions"):
            lambda1 = Lambda("Image Processing Lambda")
            lambda2 = Lambda("Notification Lambda")

    # Database
    rds = RDS("RDS Database")

    # API Gateway
    apigateway = APIGateway("API Gateway")

    # SNS Topic
    sns = SNS("SNS Topic")

    # Monitoring
    cloudwatch = Cloudwatch("CloudWatch")

    # Diagram connections
    mobile >> s3
    s3 >> apigateway >> ec2
    s3 >> lambda1
    lambda1 >> sns
    ec2 >> rds
    ec2 >> cloudwatch
    lambda2 >> sns
    sns >> cloudwatch
