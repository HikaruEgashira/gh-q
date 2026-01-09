function __gh_q_repos
    gh api user/repos --jq '.[].full_name' 2>/dev/null
end

function __gh_q_needs_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -eq 2; and test "$cmd[1]" = "gh"; and test "$cmd[2]" = "q"
        return 0
    end
    return 1
end

function __gh_q_using_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -ge 3; and test "$cmd[1]" = "gh"; and test "$cmd[2]" = "q"; and test "$cmd[3]" = "$argv[1]"
        return 0
    end
    return 1
end

complete -f -c gh -n '__gh_q_needs_command' -a 'get' -d 'Clone a repository'
complete -f -c gh -n '__gh_q_needs_command' -a 'list' -d 'List repositories'
complete -f -c gh -n '__gh_q_needs_command' -a '--' -d 'Change directory and run command'
complete -f -c gh -n '__gh_q_using_command get' -a '(__gh_q_repos)'
