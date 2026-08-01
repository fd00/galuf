# galuf

Ruby CI for Cygwin.

This repository provides GitHub Actions workflows that build and test the latest
`master` branch of [Ruby](https://github.com/ruby/ruby) and
[RubyGems](https://github.com/ruby/rubygems) on Cygwin (Windows).

## Workflows

### [`ruby.yml`](.github/workflows/ruby.yml)

- Clones `ruby/ruby` and runs `autogen.sh` → `configure` → `make` → `make test`.
- Runs daily at 19:00 UTC (`cron: '0 19 * * *'`).

### [`rubygems.yml`](.github/workflows/rubygems.yml)

- Clones `ruby/rubygems`, installs the required gems, and runs `bin/rake test`.
- Runs daily at 18:00 UTC (`cron: '0 18 * * *'`).

Both workflows are also triggered on push to `main` or manually via `workflow_dispatch`.

## Environment

Jobs run on the `windows-latest` runner. Cygwin (x86_64) is set up via
[`cygwin/cygwin-install-action`](https://github.com/cygwin/cygwin-install-action),
along with the devel packages needed to build Ruby.

## Purpose

An unofficial CI to keep track of whether Ruby and RubyGems continue to build and
pass their test suites on Cygwin.
