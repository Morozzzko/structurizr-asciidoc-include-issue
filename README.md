# Architecture model toolkit

This is a template repo for architecture modelling with a heavy focus on the very basic set-up, decisions, and the tooling to support it.

Current tooling is heavily based on [Structurizr](https://structurizr.com/) and is basically a compilation of different tools.

Here's the description of the setup:

[DIP](https://github.com/bibendi/dip) is the tool of choice for interacting with workspace. We're running Docker with Compose. DIP facilitates and unifies interactions.

[Structurizr Lite](https://structurizr.com/help/lite) for previewing, editing and interacting with workspace through browser. It's by far the most complex tool for the C4 model, and we're including it by default. Run `dip lite` to start it.

[Structurizr CLI](https://github.com/structurizr/cli) for exporting, publishing, workspace validation, and some other automation. Sometimes it's just more handy than running `Lite`. Run `dip cli` to interact with CLI. Alternatively, run `dip validate` to validate the workspace, or `dip export` to export the workspace.

[structurizr-ruby](https://github.com/Morozzzko/structurizr-ruby) for JRuby [scripting](https://github.com/structurizr/dsl/blob/master/docs/language-reference.md#scripts) and interactive REPL for querying workspace. Run `dip repl` to open a REPL session

![REPL demo session](.github/pics/demo.gif)

GitHub Actions for automated deploys.

GitHub Codespaces for editing on the go.

## Installation

1. Install `dip` using their [instructions](https://github.com/bibendi/dip#installation)
2. Run `dip build` to build Docker image with Structurizr Lite, CLI and REPL.
3. That's it!

## Running Structurizr Lite

The template incorporates the latest version of Structurizr Lite. Run `dip lite` to launch it in the current workspace

## Running Structurizr CLI

In case you need Structurizr CLI for validations, export, pushing, or anything else, there are sample commands to run it. Run `dip ls` for the full list, but here are the basic ones:

* `dip cli` – run Structurizr CLI
* `dip validate` – shortcut to `structurizr.sh validate -w workspace.dsl`
* `dip export` – shortcut to `... export -w ... -o output/`
* `dip push` – to push the workspace to Structurizr Cloud or On-Premise instance

## GitHub actions

The template comes with a GitHub action to push the workspace to Structurizr instance, either cloud or on-premise. By default, it launches on `workflow_dispatch`, meaning you need to run it automatically from `Actions` tab of your repo. 

However, if you'd like to run it automatically on each push to `main`, feel free to edit `.github/workflows/deploy_workspace.yml` and uncomment the following lines:

```yaml
  # push:
  #   branches:
  #     - main
```

That'll make it work for each push to the repo.

If you'd like to use GitHub actions, you'll need to configure environment first. See next section.

## Pushing workspace to Structurizr instance

If you have a Structurizr workspace on either structurizr.com or an on-premise installation, you'd probably want to upload your local workpace every now and then.

There are basically three ways to do so:

* `dip push` through structurizr CLI
* GitHub Actions
* GitHub Codespaces: use `structurizr.sh push`

All of those options require their own credentials. For the sake of uniformity, all the tooling assumes _the same variable names_ everywhere

* `STRUCTURIZR_WORKSPACE_ID` — workspace ID, what you'd put under `-id ...` in CLI
* `STRUCTURIZR_WORKSPACE_KEY` — workspace key, `-key ...`
* `STRUCTURIZR_WORKSPACE_SECRET` — workspace secret, `-secret ...`
* `STRUCTURIZR_URL` — structurizr instance URL, `-url https:/..`

If you'd like to have any of those features enabled, you need to supply ENV accordingly.
    
If you'd like to use `dip push` and don't want to handle env yourself, feel free to create `dip.override.yml` with the following contents:

```yaml
# dip.override.yml
# Don't forget to supply your values!
environment:
  STRUCTURIZR_WORKSPACE_ID: id
  STRUCTURIZR_WORKSPACE_KEY: key
  STRUCTURIZR_WORKSPACE_SECRET: key
  STRUCTURIZR_WORKSPACE_URL: https://api.structurizr.com
```

## Conventions

The main expectation is that you'd use this repo as a template for your workspaces and models. Feel free to fork and modify this repo to fit your own needs.

Right now the most sigificant parts of the model look like this:

```
.
├── docs
│   └── 01-test.md
│   ├── .keep
├── output
│   ├── .keep
├── workspace.dsl
└── workspace.json
```

Basically, what we've got are:

1. Workspace files -- both DSL and JSON files. DSL is supposed to be authored by us, while JSON is supposed to be generated by CLI or Structurizr Lite.
2. `docs` directory for documentation. It contains an example of embedding diagrams.
2. `output` directory for all of the CLI-generated outputs. It's gitignored, so feel free to put anything there

## License and considerations

This code is licensed under the [MIT license](LICENSE).

However, this repository distributes and incorporates other people's works.

### arc42

This repository contains a derivative of [arc42](https://arc42.org/download#file-based-formats) 8.0 at `docs/arc42`

Modifications:

* Removed images, config and root file
* `src` directory is now `arc42`

This content is licensed under [Creative Commons Attribution-ShareAlike 4.0 International License.](https://github.com/arc42/arc42-template/blob/master/LICENSE.txt)

### JRuby docker image

Dockerfile contains code from JRuby's official Docker image. It is licensed under MIT. You can see the copyright at [JRuby Docker repo](https://github.com/jruby/docker-jruby/blob/master/LICENSE.md).