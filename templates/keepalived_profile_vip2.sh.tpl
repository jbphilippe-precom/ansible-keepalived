function prompt_command {
  export PS1='\[\033[1m\]$(echo -n "VIP_2:$(cat /var/run/keepalived.VIP_2.state)")\[\033[m\] | \u@\h:\w \$ '
}
export PROMPT_COMMAND=prompt_command
