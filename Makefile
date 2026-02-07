.PHONY: test test-parsers test-integration

# Run all tests
test:
	@./run_tests.zsh

# Run parser function tests only
test-parsers:
	@./tests/test_parsers.zsh

# Run integration tests only
test-integration:
	@./tests/test_integration.zsh
