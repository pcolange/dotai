#!/usr/bin/env bash
# Points an agent's personal rules directory at this repo, so the rules are
# whatever is checked out here and an edit is a commit rather than a copy.
#
#   ./install.sh            # link
#   ./install.sh --status   # report without changing anything
#
# Idempotent: run it again after a pull, a new machine, or a tool that keeps
# its config somewhere new. An existing real directory is moved aside, never
# deleted.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
status_only=false
[[ ${1:-} == --status ]] && status_only=true

# Where each tool keeps its personal configuration. A directory is a target
# only if it already exists, so this never invents config for a tool that is
# not installed -- except the one an environment variable names outright.
targets=()
[[ -n ${CLAUDE_CONFIG_DIR:-} ]] && targets+=("$CLAUDE_CONFIG_DIR")
for dir in "$HOME/.claude" "$HOME/.claude-personal"; do
    [[ -d $dir ]] && targets+=("$dir")
done
# Unique, in order.
mapfile -t targets < <(printf '%s\n' "${targets[@]}" | awk '!seen[$0]++')

if [[ ${#targets[@]} -eq 0 ]]; then
    echo "no agent config directory found (looked for CLAUDE_CONFIG_DIR, ~/.claude, ~/.claude-personal)" >&2
    exit 1
fi

link_one() {
    local dir="$1" link="$1/rules" want="$here/rules"
    if [[ -L $link ]]; then
        local at
        at="$(readlink -f "$link")"
        if [[ $at == "$(readlink -f "$want")" ]]; then
            echo "ok        $link -> $want"
            return
        fi
        $status_only && { echo "WRONG     $link -> $at"; return; }
        rm "$link"
    elif [[ -e $link ]]; then
        $status_only && { echo "NOT LINKED $link (a real directory)"; return; }
        local keep="$link.before-dotai.$(date +%Y%m%d%H%M%S)"
        mv "$link" "$keep"
        echo "kept      $keep"
    else
        $status_only && { echo "MISSING   $link"; return; }
    fi
    mkdir -p "$dir"
    ln -s "$want" "$link"
    echo "linked    $link -> $want"
}

for dir in "${targets[@]}"; do link_one "$dir"; done
