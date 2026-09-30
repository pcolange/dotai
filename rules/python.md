---
paths:
  - "**/*.py"
---

# Python

For `tessera_search` and any other Python in the repo, on top of
`engineering.md`.

## Let the tools decide

`pyproject.toml` configures them and wins: pyright strict, ruff for lint,
format and imports. What they check is not checked by hand, and their
configured exceptions stand (docstrings are optional here; `D10x` is off).
Every signature is annotated, arguments and return. `uv run ruff check` and
`uv run pyright` pass before the work is called done.

## Idiom

- Comprehensions, f-strings, `with`, and guard clauses that return early;
  flat beats nested.
- Names: `snake_case` for functions and variables, `PascalCase` for
  classes, `UPPER_SNAKE_CASE` for constants, a leading `_` for private
  helpers.
- Hints in the modern spelling: `str | None`, `list[str]`.
- Plain data is a `@dataclass`; something with no state is a function.
- A default argument is immutable. For anything else, default to `None`
  and build the value in the body.
- Every `open()` passes `encoding="utf-8"`.
- Catch the exception that is expected. A catch-all `except Exception`
  lives only at an entry point.
- `torch`, `transformers` and other heavy modules are imported inside the
  function that uses them. No `import *`.

## Output

The `tessera_search` console scripts are CLIs: `print()` is their
interface. Anything diagnostic from library code goes to a module-level
stdlib `logging` logger at the right level, never to `print()`.
