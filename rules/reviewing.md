# Reviewing a Change

The same standard whether a person or an agent reviews: make the change
better without holding it up.

## Look for

1. **Does it work?** The change does what it says, including its error
   paths, its edges (empty, null, off by one, the boundary) and anything
   concurrent.
2. **Is it one change?** Unrelated work riding along, or a diff too large
   to read, should be split. A cohesive vertical slice is better than a
   pile of fragments that hides the intent.
3. **Is it tested?** New behaviour has tests that check outcomes, not
   internals, with the negative and edge cases in them.
4. **Is anything exposed?** Per [hygiene.md](hygiene.md): no secrets, no
   absolute paths, no internal hostnames, input checked where it enters.
5. **Do the docs still hold?** READMEs, comments and `CLAUDE.md` move in
   the same change as the behaviour, commands or environment variables they
   describe.
6. **Style and types** get a glance only. Whatever `ruff`, `pyright` or the
   project's own tools catch is theirs to report.

## Leave alone

- Matters of taste (a name, a line break, a comment's wording) unless they
  really obscure what the code means. [engineering.md](engineering.md) and
  the language rules decide style, not the reviewer's preference.
- Anything a linter would fix.
- "What if we later need X", unless this change actually blocks X.

## Writing the comments

In the voice of [voice.md](voice.md).

- Anchor each comment to a file and line.
- One point per comment.
- Offer the fix where there is one, not only the problem.
- A severity tag is optional: `blocker` (correctness or security only),
  `concern` (the default), `nit`.
- Praise rarely, and only for a choice that wasn't obvious.

## Verdict

A change that works, is one change and is tested gets approved, minor nits
and all. Something that can land in a follow-up doesn't block, unless it
touches correctness or security.

## Posting it

From an automated reviewer: inline comments at their lines, one concern
each, and one short top-level comment with the overall verdict. A person
can post the same way or however the platform allows.
