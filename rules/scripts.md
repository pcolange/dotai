---
paths:
  - "**/*.sh"
---

# Shell Scripts

For the scripts in `scripts/`, on top of `engineering.md`.

- Open with `set -euo pipefail`; quote every expansion.
- A script runs on macOS as well as Linux, so nothing GNU-only: write to a
  temp file and `mv` it rather than `sed -i`, use `cd … && pwd -P` for
  `readlink -f`, and `date +FORMAT` (or epoch arithmetic in `jq`) for
  `date -d`.
- A missing value must not become part of a path or a command. `jq -r`
  prints the word `null` for an absent field, and an unset variable expands
  to nothing; check for both before interpolating.
