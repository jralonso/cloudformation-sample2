Some notes about the project:

- The zip file contains every file needed to build the stack
- I have used nested stacks to have a cleaner layout:
    - 0_rootstack.yml is the main file
    - 1_network.yml builds the network stack
    - 2_bastion.yml builds a couple of bastion hosts one per AZ involved in the stack
    - 3_servers.yml builds the web servers stack 
- To make it work, 1_network.yml, 2_bastion.yml, 3_servers.yml must be uploaded to S3 and the template URL has to be updated accordingly.
- The included file stackparams.json provides a set of params to build the stack easily, but it can be customized.
- For convenience the stack can be build easily just doing:
    ./_create.sh <STACKNAME> 0_rootstack.yml stackparams.json
- ... and deleted using the _delete.sh script
- Be aware that the _create.sh file includes a profile pointing to my account that will be running the cloudformation.
- To access the bastion and web servers the user mus first generate a key pair and download it from console. That key pair
can be used to access Bastion first and then the web servers. To avoid storing the key file in the bastion hosts I use ssh-agent forwarding 
as suggested here https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/
- I have left a version of the project running today that can be tested here: http://fulls-webap-1fp7k9nf1nhl0-158090089.us-west-2.elb.amazonaws.com/

  
