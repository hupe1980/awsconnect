PROJECTNAME=$(shell basename "$(PWD)")

# Go related variables.
# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent

.PHONY: setup
## setup: Setup installes dependencies
setup:
	go mod tidy

.PHONY: test
## test: Runs go test with default values
test:
	go test -v -race -count=1  ./...

.PHONY: build
## build: Builds a beta version of gotoaws
build:
	go build -o dist/

.PHONY: ci
## ci: Run all the tests and code checks
ci: build test

.PHONY: run
## run: Runs gotoaws
run:
	go run main.go ec2 run -c "cat /etc/passwd"

.PHONY: help
## help: Prints this help message
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo