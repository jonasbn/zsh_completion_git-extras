#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Source the test helper
source "$SCRIPT_DIR/test_helper.zsh"

# Source the completion script
source "$SCRIPT_DIR/../_git-delete-branch"

echo "${YELLOW}Testing Parser Functions${NC}"
echo ""

# Mock git branch command for testing
git() {
    if [[ "$1" == "branch" ]]; then
        cat << 'EOF'
* main
  develop
  feature/new-feature
  bugfix/issue-123
  hotfix/critical-fix
EOF
    fi
}

# Test 1: _git_delete_branch_parse_branches
test_parse_branches() {
    local result="$(_git_delete_branch_parse_branches)"
    local expected="main
develop
feature/new-feature
bugfix/issue-123
hotfix/critical-fix"

    assert_equal "$expected" "$result" "Parse branches and remove asterisk markers"
}

# Test 2: Empty list handling
test_parse_empty_list() {
    git() { 
        if [[ "$1" == "branch" ]]; then
            echo ""
        fi
    }
    local result="$(_git_delete_branch_parse_branches)"

    assert_equal "" "$result" "Handle empty list gracefully"
}

# Test 3: Single branch in list
test_parse_single_branch() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "* main"
        fi
    }
    local result="$(_git_delete_branch_parse_branches)"

    assert_equal "main" "$result" "Handle single branch with asterisk"
}

# Test 4: Whitespace handling
test_parse_whitespace() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "  main"
            echo "    develop  "
            echo "  * feature/test  "
        fi
    }

    local result="$(_git_delete_branch_parse_branches)"
    local expected="main
develop
feature/test"

    assert_equal "$expected" "$result" "Trim leading whitespace and remove asterisks"
}

# Test 5: Multiple branches with asterisk
test_parse_with_asterisk() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "  main"
            echo "* develop"
            echo "  feature/test"
        fi
    }

    local result="$(_git_delete_branch_parse_branches)"
    assert_contains "$result" "main" "Contains main"
    assert_contains "$result" "develop" "Contains develop (asterisk removed)"
    assert_contains "$result" "feature/test" "Contains feature/test"
}

# Test 6: Branch names with slashes
test_parse_branch_names_with_slashes() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "  main"
            echo "  feature/new-feature"
            echo "  bugfix/issue-123"
            echo "  hotfix/critical-fix"
        fi
    }

    local result="$(_git_delete_branch_parse_branches)"
    assert_contains "$result" "feature/new-feature" "Handles branch names with slashes"
    assert_contains "$result" "bugfix/issue-123" "Handles bugfix branch"
    assert_contains "$result" "hotfix/critical-fix" "Handles hotfix branch"
}

# Test 7: Only asterisk marked branch
test_parse_only_asterisk_branch() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "* main"
        fi
    }
    local result="$(_git_delete_branch_parse_branches)"

    assert_equal "main" "$result" "Single branch with asterisk is cleaned"
}

# Test 8: No asterisk in list
test_parse_no_asterisk() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "  main"
            echo "  develop"
            echo "  feature/test"
        fi
    }

    local result="$(_git_delete_branch_parse_branches)"
    assert_contains "$result" "main" "Contains main when no asterisk"
    assert_contains "$result" "develop" "Contains develop when no asterisk"
    assert_contains "$result" "feature/test" "Contains feature/test when no asterisk"
}

# Test 9: Error handling (command not found or fails)
test_parse_command_error() {
    git() { 
        if [[ "$1" == "branch" ]]; then
            return 1
        fi
    }
    local result="$(_git_delete_branch_parse_branches)"

    assert_equal "" "$result" "Handle command error gracefully"
}

# Test 10: Mixed formatting
test_parse_mixed_formatting() {
    git() {
        if [[ "$1" == "branch" ]]; then
            echo "  main"
            echo "    develop"
            echo "* feature/test"
            echo "      bugfix/issue-123  "
        fi
    }

    local result="$(_git_delete_branch_parse_branches)"
    local expected="main
develop
feature/test
bugfix/issue-123"

    assert_equal "$expected" "$result" "Handle mixed formatting correctly"
}

# Run all tests
test_parse_branches
test_parse_empty_list
test_parse_single_branch
test_parse_whitespace
test_parse_with_asterisk
test_parse_branch_names_with_slashes
test_parse_only_asterisk_branch
test_parse_no_asterisk
test_parse_command_error
test_parse_mixed_formatting

# Print summary
print_summary
exit $?
