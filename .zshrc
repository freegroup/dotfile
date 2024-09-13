export PYTHONUTF8=1

autoload -Uz compinit
compinit

setopt HIST_IGNORE_ALL_DUPS

# Devbox
DEVBOX_NO_PROMPT=true
eval "$(devbox global shellenv --init-hook)"


# Git
LANG=en_US.UTF-8

# Completions
source <(devbox completion zsh)
source <(docker completion zsh)
source <(kubectl completion zsh)

# Starship
eval "$(starship init zsh)"


export PATH=$PATH:$HOME/bin/
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH="$PATH:$HOME/bin/flutter/bin"

export PATH="$PATH":"$HOME/.pub-cache/bin"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


alias copy=cp
alias ll="ls -la"
alias ke=$'eval \'export KUBECONFIG="$PWD/kubeconfig.yaml"\''
alias k="kubectl"
alias kbash="kubectl run busybox -i --tty --image=busybox --restart=Never --rm -- ash"

alias ports="lsof -i | grep LISTEN"
alias stree="open -a SourceTree"

alias password="gpg --gen-random --armor 1 30"

export DOCKER_ID_USER="freegroup"

export GOPATH=$HOME/go
# MacPorts Installer addition on 2016-03-09_at_13:31:53: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH=${PATH}:`go env GOPATH`/bin


# required for gardenctl and/or gardenlogin
#
[ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

prompt_k8s(){
  if [ -n "$KUBECONFIG" ]; then
      k8s_current_context=$(kubectl config current-context 2> /dev/null)
      if [[ $? -eq 0 ]] ; then echo -e "(${k8s_current_context}) "; fi
  fi
}
PS1+='$(prompt_k8s)'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source ~/bin/zsh_prompt_kubeconfig.zsh
source <(kubectl completion zsh)

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

_decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}
jwt() { _decode_base64_url $(echo -n $1 | cut -d "." -f ${2:-2}) | jq .; }
# jwt $TOKEN 2


