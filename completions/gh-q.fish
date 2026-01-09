# Completion for gh-q (GitHub CLI extension)
# Usage: Copy to ~/.config/fish/completions/ or source directly

function __gh_q_repos
    gh api user/repos --jq '.[].full_name' 2>/dev/null
end

# Check if we're at "gh q <TAB>" (needs subcommand)
function __gh_q_needs_command
    set -l cmd (commandline -opc)
    # For "gh q", cmd[1]=gh, cmd[2]=q
    if test (count $cmd) -eq 2; and test "$cmd[1]" = "gh"; and test "$cmd[2]" = "q"
        return 0
    end
    return 1
end

# Check if we're using a specific subcommand
function __gh_q_using_command
    set -l cmd (commandline -opc)
    # For "gh q get", cmd[1]=gh, cmd[2]=q, cmd[3]=get
    if test (count $cmd) -ge 3; and test "$cmd[1]" = "gh"; and test "$cmd[2]" = "q"; and test "$cmd[3]" = "$argv[1]"
        return 0
    end
    return 1
end

# Subcommands for "gh q"
complete -f -c gh -n '__gh_q_needs_command' -a 'get' -d 'Clone a repository'
complete -f -c gh -n '__gh_q_needs_command' -a 'list' -d 'List repositories'
complete -f -c gh -n '__gh_q_needs_command' -a '--' -d 'Change directory and run command'

# get subcommand: complete with user repos
complete -f -c gh -n '__gh_q_using_command get' -a '(__gh_q_repos)'
