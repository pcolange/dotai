# Engineering

What holds in any language. The per-language files (`python.md`, `cpp.md`,
`scripts.md`) add the mechanics.

## Shape of the code

- **One home per derived value.** A path, identifier, URL or name built
  from parts is built once and imported wherever it is used; two copies of
  the recipe will drift apart.
- **A helper arrives with the second caller.** Not before: duplication in
  plain sight is cheaper than an abstraction built on a guess. Options
  nobody asked for are scope, not foresight.
- **Fewest lines that stay clear.** A change that can delete lines should:
  no dead code, no restated logic, no wrapper that only forwards, no
  comment repeating the code. Shorter never beats readable, and never beats
  the second-caller rule above: no compressed cleverness, no abstraction
  built ahead of its second use.
- **Assume from the task, not the machine.** Whatever happens to be true of
  the box the work runs on is not a requirement.
- **Hard edges between domains.** A module owns its concern and offers an
  interface; its insides stay its own.

## Order

A list with no natural order (enum members, dependencies, config keys) is
alphabetical. An existing order is left alone, except when adding to a list
that has already drifted, which is then sorted whole in the same edit.
Lists whose order means something (numbered rules, keys grouped on purpose)
keep it.

## Docs

- A behaviour change and the docs that describe it land in one commit:
  READMEs for commands and environment variables, docstrings and header
  comments for code. Afterwards, reread the file and its neighbours for
  sentences the change made false.
- Write only what the code and context confirm. How a thing is deployed or
  consumed, if unknown, is asked, never invented; a gap in the docs can be
  filled later, a wrong claim misleads now.
- Never list the members of an open set (every file in a directory, every
  command, every key); the list goes stale with the next addition. Say
  where the set lives or what puts something in it. An example is there
  only to show a mechanism the doc is teaching.
- Serve the reader's task: how to use the thing, not how it works inside.
  Cut whatever a competent reader would have worked out alone.
- Describe the result. The steps that produced it are history, not
  documentation.

## Comments

- Few and brief; a well-chosen name says more than a comment.
- Always worth writing: a constraint the reader could not recover from the
  code.
- Present tense only. No history ("added for X"), no intentions ("TODO
  revisit").
