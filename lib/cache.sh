#!/usr/bin/env bash

ghq_root() {
    echo "${GH_Q_ROOT:-$HOME/ghq}"
}

cache_root() {
    echo "${GH_Q_CACHE:-$HOME/.cache/gh-q}"
}

_sha1() {
    if command -v sha1sum >/dev/null 2>&1; then
        sha1sum
    else
        shasum -a 1
    fi
}

# Normalise a user-supplied repo spec into the canonical `host/owner/name`
# triple plus the HTTPS URL we'll hand to git. Accepts:
#   owner/name
#   host/owner/name
#   https://host/owner/name(.git)?(/)?
#   git@host:owner/name(.git)?
normalize_repo_spec() {
    local raw="$1" host owner name path
    [[ -n "$raw" ]] || return 1

    if [[ "$raw" == git@*:* ]]; then
        host="${raw#git@}"; host="${host%%:*}"
        path="${raw#*:}"
    elif [[ "$raw" == *://* ]]; then
        path="${raw#*://}"
        host="${path%%/*}"
        path="${path#*/}"
    else
        path="$raw"
        host=""
    fi
    path="${path%.git}"
    path="${path%/}"

    local slashes="${path//[^\/]/}"
    case "${#slashes}" in
        1) # owner/name — infer host
            [[ -z "$host" ]] && host="github.com"
            owner="${path%/*}"; name="${path##*/}"
            ;;
        2) # host/owner/name
            if [[ -z "$host" ]]; then
                host="${path%%/*}"
                path="${path#*/}"
            fi
            owner="${path%/*}"; name="${path##*/}"
            ;;
        *) return 1 ;;
    esac

    [[ -n "$host" && -n "$owner" && -n "$name" ]] || return 1
    printf '%s\n%s\n%s\n' "$host" "$owner" "$name"
}

repo_target_path() {
    local host="$1" owner="$2" name="$3"
    echo "$(ghq_root)/$host/$owner/$name"
}

# Key caches by the full host/owner/name triple rather than the raw URL so
# `https://` and `git@` forms of the same repo share a single bare mirror.
repo_cache_key() {
    local host="$1" owner="$2" name="$3"
    printf '%s/%s/%s' "$host" "$owner" "$name" | _sha1 | cut -d' ' -f1
}

repo_cache_dir() {
    local key="$1"
    echo "$(cache_root)/$key"
}

repo_bare_dir() {
    local key="$1"
    echo "$(repo_cache_dir "$key")/bare"
}

repo_meta_file() {
    local key="$1"
    echo "$(repo_cache_dir "$key")/meta"
}

ensure_cache_dirs() {
    local key="$1"
    local base
    base=$(repo_cache_dir "$key")
    mkdir -p "$base" || die "cannot create cache at $base"
}
