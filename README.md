# Zsh Completion for git-extras

Zsh completion scripts for [git-extras](https://github.com/tj/git-extras) commands.

## Description

This completion provides intelligent command-line completion for git-extras commands. Currently supports:

- **git-delete-branch**: Completes with available branch names from your Git repository

## Features

- Dynamic completion based on available branches in your repository
- Automatically filters out asterisk markers from current branch
- Simple and efficient implementation following zsh completion conventions

## Installation

### Manual Installation

1. Copy the completion file to a directory in your `$fpath`:

```bash
cp _git-delete-branch /usr/local/share/zsh/site-functions/
```

2. Reload your completions:

```zsh
autoload -U compinit && compinit
```

### Using a Custom Directory

If you want to keep completions in a custom directory:

```zsh
# Add to your ~/.zshrc
fpath=(~/path/to/zsh_completion_git-extras $fpath)
autoload -U compinit && compinit
```

### Using Oh-My-Zsh

Copy or symlink the completion file to your Oh-My-Zsh completions directory:

```bash
mkdir -p ~/.oh-my-zsh/custom/plugins/git-extras
cp _git-delete-branch ~/.oh-my-zsh/custom/plugins/git-extras/
```

Then add `git-extras` to your plugins in `~/.zshrc`:

```zsh
plugins=(... git-extras)
```

## Usage

After installation, you can use tab completion with the git-delete-branch command:

```bash
git-delete-branch <TAB>
```

This will show all available branches in your repository (except the current one which will be cleaned).

## Example

```bash
$ git-delete-branch <TAB>
main  develop  feature/new-feature  bugfix/issue-123  hotfix/critical-fix
```

## Requirements

- Zsh shell
- [git-extras](https://github.com/tj/git-extras) tools installed and available in your PATH
- Git repository (for branch completion to work)

## Testing

This project includes an automated test suite to ensure the completion script works correctly.

### Running Tests

Run all tests:

```bash
make test
```

Run specific test suites:

```bash
make test-parsers      # Run parser function tests only
make test-integration  # Run integration tests only
```

Or run the test suite directly:

```bash
./run_tests.zsh
```

### Test Coverage

The test suite includes:

- **Parser Tests**: Unit tests for the `_git_delete_branch_parse_branches` function
  - Branch list parsing from `git branch` output
  - Whitespace and asterisk handling
  - Edge cases (empty lists, single branches, errors)
  - Branch names with slashes (feature/, bugfix/, hotfix/)

- **Integration Tests**: Validation of completion script structure
  - File existence and structure
  - Function definitions
  - Proper zsh completion directives
  - Syntax validation

See [tests/README.md](tests/README.md) for detailed testing documentation.

### Manual Testing

To test the completion in a clean environment:

```bash
zsh -f
fpath=(. $fpath)
autoload -U compinit
compinit
# Now test: git-delete-branch <TAB>
```

## Coding Style

This project follows zsh completion conventions:

- Completion functions start with `_`
- Use `#compdef` directive at the top of completion files
- Array format for options: `'command:description'`

## License

MIT License - Copyright (c) Jonas B. Nielsen (jonasbn) 2026

## Author

- Jonas B. Nielsen (jonasbn)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## See Also

- [git-extras](https://github.com/tj/git-extras) - The git-extras tools
- [zsh_completion_defaultbrowser](https://github.com/jonasbn/zsh_completion_defaultbrowser) - Similar completion project structure
