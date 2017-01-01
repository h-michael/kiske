# vim: ft=zsh
autoload -U colors && colors

for f in "${${(%):-%N}:A:h}"/**/*.(|z)sh(N-.)
do
    source "$f"
done
unset f

ruby_version() {
  ruby -v 2>/dev/null | awk '{print $2}'
}

node_version() {
  node -v 2>/dev/null | awk '{print $1}'
}

python_version() {
  python --version 2>/dev/null | awk '{print $2}'
}

go_version() {
  go version 2>/dev/null | awk '{print $3}'
}

ruby_prompt() {
  if [ -e .ruby-version ] && which ruby &> /dev/null; then
    echo "%{$fg_bold[red]%}rb:$(ruby_version)%{$reset_color%}"
  fi
}

node_prompt() {
  if [ -e .node-version ] && which node &> /dev/null; then
    echo "%{$fg_bold[red]%}node:$(node_version)%{$reset_color%}"
  fi
}

python_prompt() {
  if [ -e .python-version ] && which python &> /dev/null; then
    echo "%{$fg_bold[red]%}py:$(python_version)%{$reset_color%}"
  fi
}

go_prompt() {
  if [ -e .go-version ] && which go &> /dev/null; then
    echo "%{$fg_bold[red]%}$(go_version)%{$reset_color%}"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='
%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %{$fg_bold[red]%}%*%{$reset_color%}
$ '

# RPROMPT='$(ruby_prompt) $(node_prompt) $(python_prompt) $(go_prompt)'
RPROMPT='$(ruby_prompt) $(node_prompt) $(go_prompt)'
