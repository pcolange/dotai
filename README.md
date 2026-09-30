# dotai

Dotfiles for AI coding agents: rules, skills and config that travel across
tools and machines.

`rules/` holds **working-style rules** — instructions an agent loads and
follows, not settings a program reads. They describe how an agent should
work: how to communicate, how to review, how to behave inside a coding
harness.

## Install

```sh
./install.sh            # link this repo's rules into every agent config found
./install.sh --status   # report what is linked, change nothing
```

The installer points each tool's personal `rules/` directory at `rules/`
here, so the rules in force are whatever is checked out. Editing one is a
commit, and a new machine is a clone plus one command.

It is idempotent — run it after a pull, on a new machine, or when a tool
starts keeping its config somewhere new. An existing real `rules/` directory
is moved aside as `rules.before-dotai.<timestamp>`, never deleted.

Tools are found in this order: `$CLAUDE_CONFIG_DIR`, `~/.claude`,
`~/.claude-personal`. A directory has to exist already to be linked, so
nothing is invented for a tool that is not installed.

## Layout

Keep the root tool-neutral. Anything that only one tool understands goes in
a directory of its own, so a second tool is a new directory rather than a
rename.

```
rules/        working-style rules, tool-neutral
install.sh    links them into place
```

## Scope

Personal and portable. A rule that belongs to one codebase belongs in that
codebase — a repo's own `.claude/rules/` travels with the code and applies
to everyone working on it. What lives here is what should follow *you*.

Nothing secret: no keys, no tokens, no machine-specific paths worth hiding.
Public: none of it depends on staying private.
