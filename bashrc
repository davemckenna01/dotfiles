. ~/bin/bash/env
. ~/bin/bash/config
. ~/bin/bash/aliases
. ~/bin/bash/git

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function aws {
  aws-vault exec "${AWS_PROFILE:-default}" -- aws "$@"
}
 
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
      DOCKER_PASSWORD="$(aws-vault exec "${AWS_PROFILE:-hubdoc_dev}" -- aws ecr get-login-password --region us-east-1)" \
        || { echo "ECR get password failed: $DOCKER_PASSWORD"; return; };
 
      ( echo "$DOCKER_PASSWORD" | docker login --username AWS --password-stdin '260122403476.dkr.ecr.us-east-1.amazonaws.com' ) \
        || { echo 'Docker login failed!'; };
    } && return;
 
  [[ $AWS_VERSION == 1 ]] &&
    {
      local LOGIN_COMMAND;
      LOGIN_COMMAND="$(aws-vault exec "${AWS_PROFILE:-hubdoc_dev}" -- aws ecr get-login --no-include-email --region us-east-1)" \
        || { echo "ECR login failed: $LOGIN_COMMAND"; return; };
 
      eval "$LOGIN_COMMAND";
    } && return;
}

