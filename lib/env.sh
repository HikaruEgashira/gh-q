#!/usr/bin/env bash

die() {
    echo "gh-q: $*" >&2
    exit 1
}

# Portable `readlink -m`: canonicalise a path whether it exists or not.
# GNU readlink has -m; BSD (macOS) doesn't.
canonical_path() {
    local input="$1"
    [[ -n "$input" ]] || return 1
    [[ "$input" == /* ]] || input="$PWD/$input"

    local head="$input" tail=""
    while [[ ! -d "$head" ]]; do
        local base
        base=$(basename "$head")
        tail="$base${tail:+/$tail}"
        local parent
        parent=$(dirname "$head")
        [[ "$parent" == "$head" ]] && break
        head="$parent"
    done

    local resolved_head
    resolved_head=$(cd "$head" 2>/dev/null && pwd -P) || resolved_head="$head"
    if [[ -z "$tail" ]]; then
        echo "$resolved_head"
    elif [[ "$resolved_head" == "/" ]]; then
        echo "/$tail"
    else
        echo "$resolved_head/$tail"
    fi
}

require_cmd() {
    command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

require_env() {
    require_cmd git
    require_cmd gh
    # fzf/fd are only needed by specific subcommands; checked there.
}
