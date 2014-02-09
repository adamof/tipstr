# some imports
if [ -f ~/.aliases ]; then . ~/.aliases ; fi

PATH="/usr/local/bin:/usr/local/sbin:$PATH" # if not already present
PATH="$PATH:~/scripts:" # if you want to dump your own bash scripts here
export PATH=$PATH

source ~/.git-completion.bash

# colour codes
ORANGE="\[\033[0;35m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
WHITE="\[\033[0;37m\]"
WHITE_BOLD="\[\033[1;37m\]"
GRAY="\[\033[1;30m\]"
COLOR_NONE="\[\e[0m\]"

# prompt functions
function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_branch {
  # capture output of git status
  git_status="$(git status 2> /dev/null)"

  # get the time of last commit
  # time=$(git log --format='%cr' -n1 2> /dev/null)
  # git_time=$(sed "s/\([0-9]*\) \([ywdhms]\).*/\1\2/" <<< "$time")
  # if [ -n "$git_time" ]; then
  #   git_time=" ${git_time}"
  # fi

  # set color based on clean/staged/unstaged
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${ORANGE}"
  fi

  # set arrow icon based on status against remote
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # get the name of the branch
  branch_pattern="^# On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  export br=${branch}

  GIT="$BLUE(${state}${branch}$WHITE_BOLD${remote}$BLUE)"
}

function set_bash_prompt {
  if is_git_repository ; then
    set_git_branch
  else
    GIT=''
  fi

  PS1="$GRAY[\t]$WHITE\w$BLUE$GIT$COLOR_NONE\$ "
  PS2='> '
  PS4='+ '
}

# set the prompt
PROMPT_COMMAND=set_bash_prompt

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

cd /vagrant
