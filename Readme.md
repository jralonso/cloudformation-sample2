# Udacity cloudformation project 2
I have used nested stacks to have a cleaner layout:
   * 0_rootstack.yml is the main file
   * 1_network.yml builds the network stack
   * 2_bastion.yml builds a couple of bastion hosts one per AZ involved in the stack
   * 3_servers.yml builds the web servers stack 
To make it work, 1_network.yml, 2_bastion.yml, 3_servers.yml must be uploaded to S3 and the template URL has to be updated accordingly.  
The included file stackparams.json provides a set of params to build the stack easily but it can be customized. This way it is easy to change e.g. the number of min and max web servers and the instance type.

For convenience the stack can be build easily just doing:
   * ./_create.sh <STACKNAME> 0_rootstack.yml stackparams.json
... and deleted using the _delete.sh script. 
Be aware that the _create.sh file includes a profile pointing to my account that will be running the cloudformation.

# Bastion host
To access the bastion and web servers I use [EC2 Instance connect](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html)
following the configuration instructions in (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-set-up.html). This way no previous KeyPair file is needed to access the Bastion host nor the web servers. Instead you have to instal ec2-instance-connect in the instance you want to access, and configure the required IAM permissions creating a policy with the ec2-instance-connect:SendSSHPublicKey. 

The Ec2 instance connect methods are documented by AWS in (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html#ec2-instance-connect-connecting-ec2-cli). For convenience I chose to connect using EC2 Instance Connect CLI which performs the following three actions in one call: it generates a one-time-use SSH public key, pushes the key to the instance where it remains for 60 seconds, and connects the user to the instance. To be able to indentify myself using the aws cli while in the bastion host I created a user and uploaded the credentials to SSM Parameter Store. The Bastion is assigned a IAM role with a policy that allows to retrieve those params, which are used to build the aws cli credentials file in the user-data section of the bastion host.

To access the Bastion host we can just do
* $> mssh -z <AvailabilityZone> -u <AWSUserProfile> ec2-user@<BastionInstanceID>
And from Bastion host to web servers:
* $> mssh -z <AvailabilityZone> ubuntu@<WebServerInstanceID>

# Testing the cloudformation stack
I have left a version of the project running today that can be tested here (http://stack-webap-1fnhwn2wo0hks-1384516146.us-west-2.elb.amazonaws.com/)

  
