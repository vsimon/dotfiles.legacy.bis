#!/bin/zsh
export REPORTTIME=5

autoload -U promptinit; promptinit
zstyle :prompt:pure:path color 068
zstyle :prompt:pure:git:branch color green
prompt pure
