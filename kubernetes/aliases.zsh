autoload -U +X compinit && compinit
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k