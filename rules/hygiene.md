# Hygiene

What must never leave the machine in a commit, and how to patch what the
code depends on.

## Nothing tied to this machine

A path written into code, config or docs is relative to the repo. An
absolute one (`/home/...`, `C:\Users\...`) fails on the next machine and
tells a reader about this one. A location that really is machine-specific
comes in through an environment variable. Hostnames and IP addresses are
configuration too, never source. The test: a fresh clone runs unchanged on
someone else's machine and in CI.

## No credentials, ever

A key, token or password is never committed -- not in history, an example,
a fixture, and not once it has been revoked. Real values live in the
environment or a gitignored `.env`; an example file holds an obvious
stand-in such as `<your-api-key>`.

## Patching a vulnerable dependency

The fix goes in the lockfile. `pyproject.toml` says what the code needs in
order to work; `uv.lock` says what is installed, and the patched version
belongs there:

```bash
uv sync --upgrade-package "<package>>=<patched version>"
```

Raise the bound in `pyproject.toml` only if the patched release is a real
compatibility floor or the package has become a direct dependency. Then
check the lock resolved to the patched version and run the tests.
