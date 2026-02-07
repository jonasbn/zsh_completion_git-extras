#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Source the test helper
source "$SCRIPT_DIR/test_helper.zsh"

echo "${YELLOW}Testing Integration${NC}"
echo ""

# Test 1: Completion file exists
test_completion_file_exists() {
    if [[ -f "$SCRIPT_DIR/../_git-delete-branch" ]]; then
        echo "${GREEN}✓${NC} Completion file exists"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        TESTS_TOTAL=$((TESTS_TOTAL + 1))
        return 0
    else
        echo "${RED}✗${NC} Completion file exists"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        TESTS_TOTAL=$((TESTS_TOTAL + 1))
        return 1
    fi
}

# Test 2: Completion file has correct compdef
test_completion_has_compdef() {
    local content=$(cat "$SCRIPT_DIR/../_git-delete-branch")
    assert_contains "$content" "#compdef git-delete-branch" "Has #compdef directive for git-delete-branch"
}

# Test 3: Completion file defines main function
test_completion_has_main_function() {
    local content=$(cat "$SCRIPT_DIR/../_git-delete-branch")
    assert_contains "$content" "_git-delete-branch()" "Defines _git-delete-branch function"
}

# Test 4: Completion file defines parser function
test_completion_has_parser_function() {
    local content=$(cat "$SCRIPT_DIR/../_git-delete-branch")
    assert_contains "$content" "_git_delete_branch_parse_branches()" "Defines parser function"
}

# Test 5: Completion file uses _describe
test_completion_uses_describe() {
    local content=$(cat "$SCRIPT_DIR/../_git-delete-branch")
    assert_contains "$content" "_describe" "Uses _describe for completion"
}

# Test 6: Parser function uses git branch
test_parser_uses_git_branch() {
    local content=$(cat "$SCRIPT_DIR/../_git-delete-branch")
    assert_contains "$content" "git branch" "Parser function uses git branch command"
}

# Test 7: Syntax check - source the file
test_syntax_check() {
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    # Try to source the completion file
    if source "$SCRIPT_DIR/../_git-delete-branch" 2>/dev/null; then
        echo "${GREEN}✓${NC} Syntax check passes (file can be sourced)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo "${RED}✗${NC} Syntax check passes (file can be sourced)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Test 8: Function is callable
test_function_callable() {
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    # Source the file first
    source "$SCRIPT_DIR/../_git-delete-branch" 2>/dev/null
    
    # Check if function exists
    if typeset -f _git-delete-branch > /dev/null; then
        echo "${GREEN}✓${NC} _git-delete-branch function is defined and callable"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo "${RED}✗${NC} _git-delete-branch function is defined and callable"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Test 9: Parser function is callable
test_parser_function_callable() {
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    # Source the file first
    source "$SCRIPT_DIR/../_git-delete-branch" 2>/dev/null
    
    # Check if parser function exists
    if typeset -f _git_delete_branch_parse_branches > /dev/null; then
        echo "${GREEN}✓${NC} _git_delete_branch_parse_branches function is defined and callable"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo "${RED}✗${NC} _git_delete_branch_parse_branches function is defined and callable"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Run all tests
test_completion_file_exists
test_completion_has_compdef
test_completion_has_main_function
test_completion_has_parser_function
test_completion_uses_describe
test_parser_uses_git_branch
test_syntax_check
test_function_callable
test_parser_function_callable

# Print summary
print_summary
exit $?
