autoload -U +X compinit && compinit
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k

if [[ -a aliases.local.zsh ]]; then
  source aliases.local.zsh
fi
