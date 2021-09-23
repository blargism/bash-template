#! /bin/bash

echo "Command Name Here"
echo "Script template provided by Joe Mills"
echo

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

# set defaults
# Parse command line options
while getopts 'pf:' flag
do
    case "${flag}" in
        f) fqdn=${OPTARG};;
        p) is_primary=true ;;
    esac
done

# Require a fully qualified domain name
if [ -z $fqdn ]; then
    echo "A fully qualified domain name is required (-f option)"
    exit 1
fi

# Determine if the puppet server is a 
if [ "$is_primary" = true ]; then
    type="primary"
else
    type="compiler"
fi

# Example successful run
must_run ls -al
# Example failed run with warning
opt_run ls --bad-flag
# Example failed run with error and exit
must_run ls --bad-flag

