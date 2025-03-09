# START of homebrew bin path
if [[ $(uname -m) == 'arm64' ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
else
  # Write hints to STDERR, instead of STDOUT. STDOUT may break other commands.
  >&2 echo "WARNING You are not using arm64 architecture."
  >&2 echo "Your arch is: $(uname -m)".
  >&2 echo "Your default shell is: $(dscl . -read ~/ UserShell)".
  >&2 echo "This should be /bin/zsh or /opt/homebrew/bin/bash".
  >&2 echo "You can change this by running: chsh -s /bin/zsh".
fi
# END of homebrew bin path --
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
# START of pyenv_initialization
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME="$HOME/.virtualenvs"
pyenv virtualenvwrapper_lazy
export CPPFLAGS="-I$(brew --prefix openssl@3)/include -I$(brew --prefix zlib)/include"
export LDFLAGS="-L$(brew --prefix openssl@3)/lib -L$(brew --prefix zlib)/lib"
#START of Kubernetes-related aliases 
# [kubernetes] Interact with cluster resources
# if you have a customized PS1 set up and you do NOT want the kube-ps1 change, you can opt out by adding the following line BEFORE where the kubernetes-related aliases installed by salt begins
#     export KUBE_PS1_ENABLED="off"
# check if ORIGINAL_PS1 value already exists, to prevent continuously appending to PS1 everytime this file is sourced
if [ -z ${ORIGINAL_PS1+x} ]; then
    ORIGINAL_PS1=$PS1
fi
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1=$'\[\e[42m\e[37;1m\] $(kube_ps1) \[\e[0m\e[32m\e[46m\]\[\e[37;1m\] \h \[\e[0m\e[36m\e[45m\]\[\e[37;1m\] \u \[\e[0m\e[35m\e[44m\]\[\e[37;1m\] \W \[\e[0m\e[34m\e[49m\]\[\e[0m\] '

alias k="kubectl"
alias kg="k get all"
alias kgp="k get pods"
alias kdp="k describe pods"
alias klogs="k logs -c app"
alias kc="k config"
alias kcontext="kc use-context"
alias knamespace="kc set-context --current --namespace"
alias kaf="k apply -f"
# START of pip build flags 
# These build flags help grpcio build
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
# END of pip build flags --
