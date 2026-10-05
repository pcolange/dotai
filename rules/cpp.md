---
paths:
  - "**/*.cpp"
  - "**/*.h"
  - "**/*.hpp"
---

# C++

Extends `engineering.md`. The language standard is the one the build sets; no compiler-specific extensions.

## Structure

- Code lives in a namespace matching its directory (`src/cache/` → `<project>::cache`). New functionality goes in the domain it belongs to, or a new domain, not bolted onto a neighbor.
- Headers use `#pragma once`. Include order: standard library first, then project headers by repo-relative path (`"dag/hash.h"`). Include what you use; keep headers self-contained.
- Platform differences are resolved by the build selecting different source files, not by `#ifdef` blocks inside shared code.

## Naming

- `PascalCase` types, `snake_case` functions and variables, trailing-underscore private members (`entries_`).

## Idiom

- RAII and value semantics by default. `std::optional` for absent values instead of sentinels or out-params; `std::filesystem::path` for paths.
- `[[nodiscard]]` on accessors and pure functions whose result is the point of calling them.
- `= default` for compiler-writable special members; `explicit` single-argument constructors; `const` member functions wherever possible.
- Fixed-width integer types (`std::uint32_t`) where the width is part of the meaning — serialized layouts, sample rates, hashes.

## Comments

Header comments earn their place by explaining the invariant or design rationale: why the mechanism is shaped this way, what a caller must not assume. Restating a signature in prose does not.

## Verification

Build and run the project's tests before calling work done.
