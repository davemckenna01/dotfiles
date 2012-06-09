export PAGER=~/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
source /usr/local/bin/virtualenvwrapper.sh

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

export EC2_HOME=~/DevTools/ec2-api-tools-1.5.2.5
export PATH=$PATH:$EC2_HOME/bin

export EC2_PRIVATE_KEY=~/.aws/pk-J6ZNWCX65N5M4KH7465DKZVYEQ5PQTT4.pem
export EC2_CERT=~/.aws/cert-J6ZNWCX65N5M4KH7465DKZVYEQ5PQTT4.pem

export PATH=$PATH:/usr/local/mysql/bin

export JSTESTDRIVER_HOME=$HOME/bin/JsTestDriver

alias ls='ls -F'
alias kd="source kd.sh"

# Set git autocompletion and PS1 integration
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash  ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

#PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Exgxfxfxcxdxdxhbadbxbx'
