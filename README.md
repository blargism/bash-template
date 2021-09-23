# Bash Template

The bash template I like to use that provides some nicities like colors and execution flow.

This is an unlicensed bit of code in the public domain. Feel free to hack it up and improve it. PRs welcome.

## Functions

### `ann_step`

A convinience function that announces you are performing the next step in a process.

```bash
# Announce the next step, notice quotes are not required
ann_step There was something that went very wrong
```

### `ann_warning`

A convenience function that presents a warning in "yellow" or whatever "\e\[0;33;40m" ends up being on your terminal.

```bash
# Announce a warning, notice quotes are not required
ann_warning There was something that went very wrong
```

### `opt_run`

Provides the means to run a command that can fail without consiquence. It reports the run and the failure, but allows the script to continue.

```bash
# Runs fine, just some nice logging to say what is about to be run
opt_run ls -al
# Puts out the same logging, but also a warning at the end that things went wrong
opt_run ls --bad-flag
```

### `must_run`

Provides the means to run a command that must not fail. If the command has any exit code other than 0 it exits the script with that same code.

```bash
# Runs fine, just some nice logging to say what is about to be run
must_run ls -al
# Puts out the same logging and an error after, then exits.
must_run ls --bad-flag
```
