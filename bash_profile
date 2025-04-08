if [ -f ~/.bashrc ]; then
   . ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# export PATH=${PATH}:~/Library/Python/2.7/bin
# added by Anaconda2 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda2/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda2/etc/profile.d/conda.sh" ]; then
        . "/anaconda2/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
# added by Anaconda2 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda2/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda2/etc/profile.d/conda.sh" ]; then
        . "/anaconda2/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/dave.mckenna/.sdkman"
[[ -s "/Users/dave.mckenna/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/dave.mckenna/.sdkman/bin/sdkman-init.sh"

#export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dave.mckenna/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dave.mckenna/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dave.mckenna/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dave.mckenna/google-cloud-sdk/completion.bash.inc'; fi

# Created by `pipx` on 2025-02-22 21:56:02
export PATH="$PATH:/Users/dave.mckenna/.local/bin"

# Added by Windsurf
export PATH="/Users/dave.mckenna/.codeium/windsurf/bin:$PATH"

eval "$(pyenv init -)"
