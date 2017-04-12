#!/bin/bash
# OS161
update_token=$2
PATH=$HOME/tools/sys161/bin:$HOME/tools/os161/bin:$PATH
OS161_KERNEL_COMPILE="/home/nebulam/Documents/os161/src/kern/compile/DUMBVM"
OS161_ROOT="/home/nebulam/Documents/os161/root"
alias os161="sys161 -c $OS161_ROOT/sys161.conf $OS161_ROOT/kernel"
alias make-os161-kernel="bmake -C $OS161_KERNEL_COMPILE depend && bmake -C $OS161_KERNEL_COMPILE && bmake -C $OS161_KERNEL_COMPILE install"

# grep
alias ogrep="bash $1/grep_and_open/ogrep.sh"
alias rgrep="grep -rns"

#power

alias reboot="rm -f $update_token && sudo reboot now"
alias shutdown="rm -f $update_token && sudo shutdown now"
