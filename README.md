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
  gh q <command>      ... Search via fzf and run <command> with selected directory as argument
```

## Usage

```bash
# Install
gh extension install HikaruEgashira/gh-q

# ghq get owner/repo equivalent to
gh q get owner/repo
```

## fzf Native Integration

### Path Argument Mode
Passes the selected directory path as an argument to the command.
```bash
gh q code        # Opens VS Code with the selected directory
```

### Directory Change Mode
Changes to the selected directory first, then executes the command.
```bash
gh q -- claude        # Run Claude Code in the selected directory
gh q --               # Opens a shell in the selected directory
```

## Blog post

[[gh-q] gh extensionでghqを置き換える - Zenn](https://zenn.dev/sqer/articles/4bfc05e7ec4eb4)

## Acknowledgements

- [`gh-wt`](https://github.com/HikaruEgashira/gh-wt): Git worktree management
