# CircleCI Split Config Example

Unofficial config examples to run CircleCI workflows with [path-filtering orb](https://circleci.com/developer/orbs/orb/circleci/path-filtering) and splitted config files.

## Features

1. Each package has their config file
2. CI job runs only when the corresponded package files changed

## Usage

1. Fork this github project  
https://github.com/algas/circleci-split-example
2. Set Up the CircleCI project  
https://app.circleci.com/projects/project-dashboard/github/YOUR_NAME
3. Enable dynamic config using setup workflows  
Turn on "Project Settings" > "Advanced" > "Enable dynamic config using setup workflows"
4. Commit and push files in a package

## Structure

- packages:
  - foo: (your app1)
  - bar: (your app2)
- .circleci:
  - config.yml (main config)
- workflows: (splitted config files)
  - _base.yml (config template)
  - packages:
    - foo.yml (config for package "foo")
    - bar.yml (config for package "bar")

## Merged config file

This file is not in this repository.
It will be generated dynamically in CircleCI.

```merged.yml
version: 2.1
parameters:
  run-bar:
    type: boolean
    default: false
  run-foo:
    type: boolean
    default: false
jobs:
  bar:
    docker:
      - image: cimg/base:2021.04
    steps:
      - checkout
      - run:
          name: The First Bar Step
          command: |
            echo 'Hello World!'
            echo 'this is bar package'
  foo:
    docker:
      - image: cimg/base:2021.04
    steps:
      - checkout
      - run:
          name: The First Foo Step
          command: |
            echo 'Hello World!'
            echo 'foo package'
workflows:
  bar:
    when: << pipeline.parameters.run-bar >>
    jobs:
      - bar
  foo:
    when: << pipeline.parameters.run-foo >>
    jobs:
      - foo
```

## Reference

- https://circleci.com/docs/2.0/using-dynamic-configuration/#execute-specific-workflows-or-steps-based-on-which-files-are-modified

