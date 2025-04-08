. ~/bin/bash/env
. ~/bin/bash/config
. ~/bin/bash/aliases
. ~/bin/bash/git

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function terraform {
  aws-vault exec "${AWS_PROFILE:-default}" -- terraform "$@"
}
 
function packer {
  aws-vault exec "${AWS_PROFILE:-default}" -- packer "$@"
}
 
function ansible-playbook {
  aws-vault exec "${AWS_PROFILE:-default}" -- ansible-playbook "$@"
}
 
function change_aws_profile {
  unset AWS_VAULT
  local AWS_VAULT_VERSION
  AWS_VAULT_VERSION="$(command aws-vault --version 2>&1 >/dev/null | sed -n 's/^v\(.\).*/\1/p')"
 
  [[ $AWS_VAULT_VERSION > 5 ]] &&
    {
  for v in $(aws-vault exec "${AWS_PROFILE:-default}" --duration=60m -- env | grep AWS_); do
    eval "export $v"
  done
    }
 
  [[ $AWS_VAULT_VERSION < 5 ]] &&
    {
  for v in $(aws-vault exec "${AWS_PROFILE:-default}" --assume-role-ttl=60m -- env | grep AWS_); do
    eval "export $v"
  done
    }
}
 
function aws-ecr-login {
  local AWS_VERSION
  AWS_VERSION="$(command aws --version | sed -n 's/^aws-cli\/\(.\).*/\1/p')"
 
  [[ $AWS_VERSION == 2 ]] &&
    {
      local DOCKER_PASSWORD;
      DOCKER_PASSWORD="$(aws-vault exec "${AWS_PROFILE:-Developer-xero-hubdoc-dev}" -- aws ecr get-login-password --region us-east-1)" \
        || { echo "ECR get password failed: $DOCKER_PASSWORD"; return; };
 
      ( echo "$DOCKER_PASSWORD" | docker login --username AWS --password-stdin '260122403476.dkr.ecr.us-east-1.amazonaws.com' ) \
        || { echo 'Docker login failed!'; };
    } && return;
 
  [[ $AWS_VERSION == 1 ]] &&
    {
      local LOGIN_COMMAND;
      LOGIN_COMMAND="$(aws-vault exec "${AWS_PROFILE:-Developer-xero-hubdoc-dev}" -- aws ecr get-login --no-include-email --region us-east-1)" \
        || { echo "ECR login failed: $LOGIN_COMMAND"; return; };
 
      eval "$LOGIN_COMMAND";
    } && return;
}

source ~/Development/aws-sso-tools/aws-sso.sh

export PATH="/opt/homebrew/opt/python@3/libexec/bin:$PATH"

#SSM port fordwarding aliases

alias app1db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack1.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54321\"]}'"
alias app1s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack1.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app2db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack2.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54322\"]}'"
alias app2s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack2.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app3db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack3.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54323\"]}'"
alias app3s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack3.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app4db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack4.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54324\"]}'"
alias app4s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack4.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app5db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack5.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54325\"]}'"
alias app5s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack5.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app6db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack6.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54326\"]}'"
alias app6s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack6.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias app7db="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack7.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"54327\"]}'"
alias app7s3="aws ssm start-session --target  i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"test-productstack7.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"8000\"], \"localPortNumber\":[\"8000\"]}'"

alias hubdocdb-uat-master="aws ssm start-session --target i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"hubdocdb-uat-master.cjs0ntkfxpft.us-east-1.rds.amazonaws.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"15432\"]}'"

alias rabbitmq-uat="aws ssm start-session --target i-07c33f48b09bcfb4f --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"uat-productstack1.infra.staging.int.us-east-1.ci.hubdoc.com\"],\"portNumber\":[\"15672\"], \"localPortNumber\":[\"15672\"]}'"

alias rundeck-prod="aws ssm start-session --target i-0457680c473e7b4cd --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"rundeck1.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"4440\"], \"localPortNumber\":[\"4440\"]}'"

alias rabbitmq-prod="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"rabbitmqcluster2.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"15672\"], \"localPortNumber\":[\"15672\"]}'"

alias metricsdb-prod-master="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"metricsdb-prod-master.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"25432\"]}'"

alias metricsdb-prod-read-replica="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"metricsdb-prod-read-replica.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"35432\"]}'"

alias hubdocdb-production-bi-replica="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"hubdocdb-production-bi-replica.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"45432\"]}'"

alias hubdocdb-production-read-replica="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"hubdocdb-production-read-replica-2022.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"55432\"]}'"

alias airflow-prod="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"airflow-prod.prod.us-east-1.int.hubdoc.com\"],\"portNumber\":[\"5432\"], \"localPortNumber\":[\"65432\"]}'"

alias metricsdw-obf-redsfhit-prod="aws ssm start-session --target i-01184259a8f88af83 --document-name Xero-SIA-SSMHubdocPortForwarding --parameters '{\"host\":[\"metricsdw-obf.cz0wxh1td9jx.us-east-1.redshift.amazonaws.com\"],\"portNumber\":[\"5439\"], \"localPortNumber\":[\"5439\"]}'"

# Created by `pipx` on 2025-02-22 21:56:02
export PATH="$PATH:/Users/dave.mckenna/.local/bin"
