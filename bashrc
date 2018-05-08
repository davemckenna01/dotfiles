. ~/bin/bash/env
. ~/bin/bash/config
. ~/bin/bash/aliases
. ~/bin/bash/git

# added by travis gem
[ -f /Users/davemckenna/.travis/travis.sh ] && source /Users/davemckenna/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/Users/davemckenna/Library/Python/2.7/bin
