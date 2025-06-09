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
  gh q *your_command* ... Search via fzf and run *your_command* in the selected directory


$ gh q --help
Usage:
  gh q get <repo>     ... リポジトリを~/ghq/github.comにクローン
  gh q list           ... ~/ghq/github.comにある全リポジトリを表示
  gh q *your_command* ... fzfで検索し、選択したディレクトリで*your_command*を実行
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
