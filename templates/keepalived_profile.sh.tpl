function prompt_command {
  export PS1='\[\033[1m\]$(echo -n "$(cat /var/run/keepalived.state)")\[\033[m\] | \u@\h:\w \$ '
}
export PROMPT_COMMAND=prompt_command
