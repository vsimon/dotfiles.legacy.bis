#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew tap | grep -q 'getantibody/tap' || brew tap getantibody/tap
	brew install antibody
else
	curl -sL https://git.io/antibody | sudo sh -s -- -b /usr/local/bin
fi
ANTIBODY_ROOT=$(dirname ${BASH_SOURCE[0]-$0})
if [ -d "~/Library/Caches/antibody" ]; then
  rm -rf ~/Library/Caches/antibody
fi
antibody bundle <"$ANTIBODY_ROOT/bundles.txt" >~/.zsh_plugins.sh
antibody update
