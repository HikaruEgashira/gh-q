_gh_q_repos() {
  gh api user/repos --jq '.[].full_name' 2>/dev/null
}

_gh_q_complete() {
  local cur prev words cword
  _init_completion || return

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

_gh_q() {
  _gh_q_complete
}

complete -F _gh_q gh-q
complete -F _gh_q -o default gh q 2>/dev/null || true
