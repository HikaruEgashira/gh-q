# Completion for gh-q (GitHub CLI extension)
# Usage: source this file in ~/.bashrc

_gh_q_repos() {
  gh api user/repos --jq '.[].full_name' 2>/dev/null
}

_gh_q_complete() {
  local cur prev words cword
  _init_completion || return

  # For "gh q", we need to check position relative to "q"
  local cmd_index=1
  if [[ "${words[0]}" == "gh" && "${words[1]}" == "q" ]]; then
    cmd_index=2
  fi

  local effective_cword=$((cword - cmd_index + 1))

  if [[ $effective_cword -eq 1 ]]; then
    COMPREPLY=($(compgen -W "get list --" -- "$cur"))
    COMPREPLY+=($(compgen -c -- "$cur"))
    return
  fi

  case "${words[$cmd_index]}" in
    get)
      if [[ $effective_cword -eq 2 ]]; then
        local repos
        repos=$(_gh_q_repos)
        COMPREPLY=($(compgen -W "$repos" -- "$cur"))
      fi
      ;;
    list)
      ;;
    --)
      _command_offset $((cmd_index + 1))
      ;;
    *)
      ;;
  esac
}

# Wrapper for "gh q" completion
_gh_q() {
  # Check if we're completing "gh q ..."
  if [[ "${COMP_WORDS[0]}" == "gh" && "${COMP_WORDS[1]}" == "q" ]]; then
    _gh_q_complete
  else
    _gh_q_complete
  fi
}

complete -F _gh_q gh-q
complete -F _gh_q -o default gh q 2>/dev/null || true
