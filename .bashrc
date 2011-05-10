export PATH=/usr/local/bin:/opt/local/bin:/usr/local/mysql/bin:~/dev/fieldmarshal:~/dev/android-sdk/tools:~/dev/eclipse:$PATH
export JAVA_HOME=/Library/Java/Home

alias sc='vim ~/.bashrc && source ~/.bashrc'
alias ss=script/server
alias rs='script/rails server'
alias c=script/console
alias lvi='vim -c "normal '\''0"'
alias 2vi='vim -c "normal '\''1"'
alias 3vi='vim -c "normal '\''2"'
alias ux='cd /www/aboutus/ux'
alias auc='cd /www/aboutus/compostus/compost'
alias j5='cd /www/aboutus/johnny5'
alias dws='cd /www/aboutus/dotwiki'
alias dc='cd /www/aboutus/dotcom'
alias ux='cd /www/aboutus/ux'
alias hs='cd /www/aboutus/hive-scripts'
alias dp='perl ~/dev/diff_painter/diff_painter.pl | cat | more -r'
# put this in your .bashrc or .profile
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
PS1='\n\n\w $(parse_git_branch) $ '

source ~/.git-completion.sh
export TERM=xterm-color
export VISUAL=`which vim`
