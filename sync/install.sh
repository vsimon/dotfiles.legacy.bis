if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

echo "› ln -sf $HOME/Sync/.ssh $HOME/.ssh"
ln -sf $HOME/Sync/.ssh $HOME/.ssh