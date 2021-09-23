#! /bin/bash

# Written by Joe Mills (http://github.com/blargism/bash-template)

# UNLICENSE
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to <https://unlicense.org>

#####################################
# Set runtime options and functions #
#####################################

# Ansi color code variables
red="\033[0;91m"
blue="\033[0;94m"
green="\033[0;92m"
yellow="\033[0;33m"
white="\033[0;97m"
bold="\033[1m"

nc="\033[0m"
# Per use colors
step_color="\033[1;4m"
warning_color="\033[0;33;40m"

# Run a command and exit if it fails
must_run() {
    command=${@:1}
    echo
    echo -e "${bold}Running: $command${nc}"
    eval $command
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo
        >&2 echo -e "${red}ERROR:${nc} ${bold}\"${command}\"${nc} ${red}command failed with exit code${nc} ${bold}${exit_code}.${nc}"
        exit $exit_code
    fi
}

# Run a command and warn if it fails
opt_run() {
    command=${@:1}
    echo
    echo -e "${bold}Running: $command${nc}"
    eval $command
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        >&2 echo -e "${yellow}WARNING:${nc} ${bold}\"${command}\"${nc} ${yellow}command failed with exit code${nc} ${bold}${exit_code}.${nc}"
        echo
    fi
}

# Set step announcement function
step_count=0
ann_step() {
    step_count=$((step_count+1))
    echo
    echo -e "${step_color}>> Step ${step_count} >> ${1}${reset}"
    echo
}

ann_warning() {
    echo -e "${warning_color}${@:1}${nc}"
}

# enable !! command completion
set -o history -o histexpand

############################
# Script title and purpose #
############################
echo
echo -e "${bold}Command Name Here${nc}"
echo
echo "Script template provided by Joe Mills"
echo

################
# Flag parsing #
################
# set defaults

# Parse command line options
while getopts 'pf:' flag
do
    case "${flag}" in
        f) fqdn=${OPTARG};;
        p) is_primary=true ;;
    esac
done

# Example flag
# Determine if the thing is primary or not
if [ "$is_primary" = true ]; then
    type="primary"
else
    type="not-primary"
fi

# Example flag with an argument, in this case a fully qualified domain name
if [ -z $fqdn ]; then
    echo "A fully qualified domain name is required (-f option)"
    exit 1
fi


# Example successful run
must_run ls -al
# Example failed run with warning
opt_run ls --bad-flag
# Example failed run with error and exit
must_run ls --bad-flag

