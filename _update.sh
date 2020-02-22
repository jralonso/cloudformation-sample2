aws cloudformation update-stack \
--stack-name $1 \
--template-body file://$2 \
--parameters file://$3 \
--region=us-west-2 \
--profile=jra-udacity \
--capabilities CAPABILITY_IAM