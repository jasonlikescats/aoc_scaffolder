[![Build Status](https://travis-ci.org/jasonlikescats/aoc_scaffolder.svg?branch=main)](https://travis-ci.org/jasonlikescats/aoc_scaffolder)

# aoc_scaffolder

A simple tool that downloads puzzle input and does some simple
quickstart scaffolding for [Advent of Code](https://adventofcode.com/).

## Installation

Requires Crystal (tested on v0.35.1)

## Usage

1. Create a file in the working directory where this tool will be invoked
  named `session` containing the hexadecimal cookie value in use for requests
  to the Advent of Code site when logged in (this can easily be obtained
  using browser dev tools).
2. To run:
  a. For the current day (placing output in the parent directory '..'), run
  `crystal run src/aoc_scaffolder.cr`. You may also choose to compile with
  `crystal build src/aoc_scaffolder.cr` and then invoke the compiled binary
  directly.
  b. For any other day, run the program with any of the available options:
  ```
  $ crystal run src/aoc_scaffolder.cr -- -h
  Advent of Code Daily Scaffolder
      -y YEAR, --year=YEAR             Event year
      -d DAY, --day=DAY                Event day
      -p PATH, --path=PATH             Relative path to directory to place the scaffolded data
      -h, --help                       Show this help
  ```

## Roadmap
1. Add unit test creation to the scaffolding
2. Utilize `crystal init` to setup the directory for each day?
3. Add a Makefile to the set of scaffolded files
4. Add some tests
5. Turn on CI
