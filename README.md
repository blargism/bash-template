# Bash Template

The bash template I like to use that provides some nicities like colors and execution flow.

This is an unlicensed bit of code in the public domain. Feel free to hack it up and improve it. PRs welcome.

## Functions

### `ann_step`

A convinience function that announces you are performing the next step in a process.

### `ann_warning`

A convenience function that presents a warning in "yellow" or whatever "\e\[0;33;40m" ends up being on your terminal.

### `opt_run`

Provides the means to run a command that can fail without consiquence. It reports the run and the failure, but allows the script to continue.

### `must_run`

Provides the means to run a command that must not fail. If the command has any exit code other than 0 it exits the script with that same code.
