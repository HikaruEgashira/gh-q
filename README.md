<h2 align="center">
    <p align="center">gh-q</p>
</h2>

<h3 align="center">
🔹<a  href="https://github.com/HikaruEgashira/gh-q/issues">Report Bug</a> &nbsp; &nbsp;
🔹<a  href="https://github.com/HikaruEgashira/gh-q/issues">Request Feature</a>
</h3>



```bash
$ gh q --help
Usage:
  gh q get <repo>     ... Clone a repository into ~/ghq/github.com
  gh q list           ... List all repositories in ~/ghq/github.com
  gh q -- <command>   ... Search via fzf and run <command> in the selected directory
  gh q <command>      ... Search via fzf and run <command> with selected directory as argument


$ gh q --help
Usage:
  gh q get <repo>     ... リポジトリを~/ghq/github.comにクローン
  gh q list           ... ~/ghq/github.comにある全リポジトリを表示
  gh q -- <command>   ... fzfで検索し、選択したディレクトリで<command>を実行
  gh q <command>      ... fzfで検索し、選択したディレクトリを引数として<command>を実行
```

## Command Execution Modes

### Path Argument Mode: `gh q <command>`
Passes the selected directory path as an argument to the command.
```bash
gh q code        # Opens VS Code with the selected directory
gh q ls -la      # Lists files in the selected directory
```

### Directory Change Mode: `gh q -- <command>`
Changes to the selected directory first, then executes the command.
```bash
gh q -- claude        # Run Claude Code in the selected directory
gh q -- npm test      # Runs npm test in the selected directory
```

## Blog post

[[gh-q] gh extensionでghqを置き換える - Zenn](https://zenn.dev/sqer/articles/4bfc05e7ec4eb4)

## Usage

```bash
# Install
gh extension install HikaruEgashira/gh-q
gh q get HikaruEgashira/gh-q
```
  
## Related Projects

- [gh-wt](https://github.com/HikaruEgashira/gh-wt) - Git worktree management extension for GitHub CLI

## Acknowledgements

- https://docs.github.com/ja/github-cli/github-cli/creating-github-cli-extensions
