# Tests for zsh_completion_git-extras

This directory contains the test suite for the git-delete-branch zsh completion script.

## Running Tests

### All Tests

Run all tests using the main test runner:

```bash
./run_tests.zsh
```

Or using Make:

```bash
make test
```

### Individual Test Suites

Run only parser tests:

```bash
./tests/test_parsers.zsh
# or
make test-parsers
```

Run only integration tests:

```bash
./tests/test_integration.zsh
# or
make test-integration
```

## Test Structure

### Parser Tests (`test_parsers.zsh`)

Tests for the `_git_delete_branch_parse_branches` function:

- Branch list parsing from `git branch` output
- Whitespace and asterisk handling
- Edge cases (empty lists, single branches, errors)
- Branch names with slashes (feature/, bugfix/, hotfix/)

### Integration Tests (`test_integration.zsh`)

Tests for the completion script structure:

- File existence and structure
- Function definitions
- Proper zsh completion directives (#compdef)
- Syntax validation
- Function callability

## Test Helper

The `test_helper.zsh` file provides common test utilities:

- `assert_equal(expected, actual, test_name)` - Assert two values are equal
- `assert_contains(haystack, needle, test_name)` - Assert a string contains a substring
- `print_summary()` - Print test results summary

## Writing New Tests

To add new tests:

1. Source the test helper: `source "$SCRIPT_DIR/test_helper.zsh"`
2. Source the completion script if needed: `source "$SCRIPT_DIR/../_git-delete-branch"`
3. Write test functions that use the assertion helpers
4. Call your test functions
5. Call `print_summary` at the end
6. Exit with the appropriate status: `exit $?`

Example:

```zsh
#!/usr/bin/env zsh

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/test_helper.zsh"
source "$SCRIPT_DIR/../_git-delete-branch"

test_my_feature() {
    local result="some_value"
    assert_equal "some_value" "$result" "My feature test"
}

test_my_feature
print_summary
exit $?
```
