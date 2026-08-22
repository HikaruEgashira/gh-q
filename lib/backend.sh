#!/usr/bin/env bash

# Which copy-reduction strategy to use when materialising a working clone
# from the bare cache. Detection is memoised for the life of the process.
#
#   apfs       → macOS APFS clonefile(2) via `cp -c` (helper-free CoW)
#   hardlink   → `git clone --local` hardlinks objects into the clone
#   none       → fall back to a plain copy (cross-filesystem safety net)
#
# Linux OverlayFS is intentionally not used here: gh-q stores long-lived
# working trees, not transient sessions, so a mount per repo would be
# operationally awkward (sudo per `get`, umount on removal). `--local`
# hardlinks already achieve CoW-on-modify semantics on ext4/btrfs/xfs.

apfs_clone_available() {
    if [[ -n "${GH_Q_APFS_CLONE:-}" ]]; then
        [[ "$GH_Q_APFS_CLONE" == 1 ]]
        return
    fi
    local dir
    dir=$(mktemp -d 2>/dev/null) || { export GH_Q_APFS_CLONE=0; return 1; }
    : > "$dir/src"
    if cp -c "$dir/src" "$dir/dst" 2>/dev/null; then
        export GH_Q_APFS_CLONE=1
        rm -rf "$dir"
        return 0
    fi
    export GH_Q_APFS_CLONE=0
    rm -rf "$dir"
    return 1
}

resolve_backend() {
    if [[ -n "${GH_Q_RESOLVED_BACKEND:-}" ]]; then
        echo "$GH_Q_RESOLVED_BACKEND"
        return 0
    fi
    local resolved
    case "$(uname -s)" in
        Darwin)
            if apfs_clone_available; then
                resolved=apfs
            else
                resolved=hardlink
            fi
            ;;
        Linux)
            resolved=hardlink
            ;;
        *)
            resolved=none
            ;;
    esac
    export GH_Q_RESOLVED_BACKEND="$resolved"
    echo "$resolved"
}
