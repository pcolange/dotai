# How an Agent Conducts Itself

These govern the agent, not the code: how it stages work, when it runs a
command, what it leaves to the person at the keyboard.

## Stage by path

`git add -A`, `git add --all`, `git add .` and `git commit -a` are never
used. A working tree often holds the person's own work (notes, downloads,
assets, edits in progress) and build output that `.gitignore` misses, and a
sweep commits it into an unrelated change that then takes a follow-up
commit or a history rewrite to undo. Look at `git status --short`, then
name each file the change touched, counting the generated ones it owns,
such as a lockfile the change updated. `git add -u` is fine only when every
modified file is provably part of the change and nothing untracked belongs
in it. Before committing, read `git diff --cached --stat` and account for
every path in it.

## Name the branch for the change

A branch is named for the feature or fix it carries, in lowercase words
joined by hyphens: `pr-description-rules`, not `claude/dreamy-feynman-6c5vfn`.
A name the tooling generates is replaced with one like that before the
first push.

## Keep safe commands off the prompt

This is about read-only commands and edits inside the workspace: status
checks, linters, formatters, file edits. Anything that reaches past the
local files (a push, a deploy, a remote deletion, a write to an outside
system) should prompt every time; that prompt is the safeguard, and the
agent never reshapes a command to dodge it.

For the safe kind, read `permissions.allow` in the settings files early,
before the first shell command that needs it. When two commands do the same
thing and one is already allowed, use that one: a bare tool on `PATH` rather
than the same tool behind `uv run`, say. The two must really be equivalent;
a quieter command is never worth a less correct one. A safe command that
will run again and again with no allowed equivalent gets an allowlist entry
proposed up front, and one that has prompted twice in a session stops being
run until it has one.

How the matcher behaves:

- It matches by prefix. The plain read-only commands (`ls`, `cat`, `grep`,
  `find`, `diff`, and git's `status`, `diff`, `log`, `branch`) never prompt;
  the `Read`, `Grep` and `Glob` tools are better still.
- A compound command is judged piece by piece across `&&`, `;`, `|` and
  newlines, so one unapproved piece makes the whole line prompt.
- `cd` and `git` in one command always prompt. Change directory in one call
  (it persists) and run git in the next. `git -C <dir>` breaks the prefix
  and prompts too.
- A runner such as `uv run`, `npx` or `docker exec` is part of what gets
  matched, so the rule names both; `timeout` and `nice` are stripped first.
- Subagents prompt the person the same way. Hand them read-only or allowed
  commands, or one fan-out turns into a queue of prompts.

## A checkout that isn't fit to work in

Behind the remote, on the wrong branch, `HEAD` detached, uncommitted work
in the way, files that should be there missing: look with read-only git,
say exactly what was found and what would fix it, and stop. The agent does
not `pull`, `reset`, `checkout` or `switch` on its own, and does not rebuild
missing content from a cache or a guess. Which branch and which local work
matter is the person's knowledge, not the agent's.

## Which settings file

A setting everyone who clones the repo should have goes in the repo's
committed settings; one for this machine or this person goes in the
personal settings directory. Levels union and `deny` wins, so add only the
missing entry, at the right level. If the level is unclear, ask, leaning
toward the committed file so the setting travels with the code.
