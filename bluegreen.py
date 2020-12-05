#!/usr/bin/env python

import boto3
import getopt
import sys
import subprocess
import time
from datetime import datetime


def main(argv):
    helptext = 'bluegreen.py -f <path to terraform project> -a <ami> -c <command> -t <timeout> -e <environment.tfvars> -i <inactive-desired> [-r <assume-role-arn>]'

    try:
        opts, args = getopt.getopt(argv, "hsf:a:c:t:e:i:r:", ["folder=", "ami=", "command=", "timeout=", "environment=", "inactive-desired=", "role-arn"])
    except getopt.GetoptError:
        print(helptext)
        sys.exit(2)

    if opts:
        for opt, arg in opts:
            if opt == '-h':
                print(helptext)
                sys.exit(2)
            elif opt in ("-f", "--folder"):
                projectPath = arg
            elif opt in ("-a", "--ami"):
                ami = arg
            elif opt in ("-c", "--command"):
                command = arg
            elif opt in ("-t", "--timeout"):
                maxTimeout = int(arg)
            elif opt in ("-e", "--environment"):
                environment = arg
            elif opt in ("-i", "--inactive-desired"):
                inactiveDesired = arg
            elif opt in ("-r", "--role-arn"):
                assumeRoleArn = arg
            elif opt in ("-s"):
                stopScaling = True
    else:
        print(helptext)
        sys.exit(2)

    if 'command' not in locals():
        command = 'plan'

    if 'maxTimeout' not in locals():
        maxTimeout = 200

    if 'projectPath' not in locals():
        print('Please give your folder path of your Terraform project')
        print(helptext)
        sys.exit(2)

    if 'ami' not in locals():
        print('Please give a new AMI as argument')
        print(helptext)
        sys.exit(2)

    if 'environment' not in locals():
        environment = None

    if 'inactiveDesired' not in locals():
        inactiveDesired = 1

    if 'assumeRoleArn' not in locals():
        assumeRoleArn = None

    if 'stopScaling' not in locals():
        stopScaling = False

    global inactiveAutoscalingGroups
    inactiveAutoscalingGroups = False

    agBlue = getTerraformOutput(projectPath, 'blue_asg_id')
    agGreen = getTerraformOutput(projectPath, 'green_asg_id')

    global awsSession
    awsSession = getBotoSession(assumeRoleArn)

    info = getAutoScalingInfo(agBlue, agGreen)

    active = getActive(info)

def getBotoSession(assumeRoleArn):
    if assumeRoleArn:
        sts_client = boto3.client('sts')

        assumed_role_object = sts_client.assume_role(
            RoleArn = assumeRoleArn,
            RoleSessionName = "bluegreen"
        )

        return boto3.Session(
            aws_access_key_id = assumed_role_object['Credentials']['AccessKeyId'],
            aws_secret_access_key = assumed_role_object['Credentials']['SecretAccessKey'],
            aws_session_token = assumed_role_object['Credentials']['SessionToken']
        )
    else:
        return boto3.Session()

def getTerraformOutput(projectPath, output):
    process = subprocess.Popen('terraform output ' + output, shell=True, cwd=projectPath, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    std_out, std_err = process.communicate()
    if process.returncode != 0:
        err_msg = f"{stderr.strip()}. Code: {process.returncode}"
        print(err_msg)
        sys.exit(process.returncode)

    return std_out.rstrip()

def getAutoScalingInfo(blue, green):
    client = awsSession.client('autoscaling')
    response = client.describe_auto_scaling_groups(
        AutoScalingGroupNames=[
            blue,
            green,
        ],
        MaxRecords=2
    )
    return response

def getActive(info):
    if info['AutoScalingGroups'][0]['DesiredCapacity'] > 0 and info['AutoScalingGroups'][1]['DesiredCapacity'] == 0:
        print('Blue is active')
        return 0
    elif info['AutoScalingGroups'][0]['DesiredCapacity'] == 0 and info['AutoScalingGroups'][1]['DesiredCapacity'] > 0:
        print('Green is active')
        return 1
        
if __name__ == "__main__":
    main(sys.argv[1:])