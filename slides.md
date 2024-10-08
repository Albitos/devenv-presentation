---
theme: default
title: Easy development environments with Nix
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
lineNumbers: true
addons:
  - slidev-addon-asciinema
---

# <img src="/images/nix-logo.svg" class="nix-logo" style="display: inline; width: 200px; position: relative; top: -10px;" alt="Nix logo"> + <img src="/images/devenv-dark-bg.svg" class="devenv-logo" style="position: relative; display: inline; width: 200px" alt="Slidev logo"> = ❤️
 

## Portable local development environments with Nix

How to make sure that you local environment<br>is consistent across the team<br> and easy to set up? 

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---
transition: slide-left
layout: two-cols
layoutClass: gap-16
---

# Who am I?

- Team Lead @<img src="/images/monday.svg" class="monday-logo" style="display: inline; width: 200px" alt="monday.com logo">
- Over 16 years of commercial experience in programming. 
- I have an obsession with productivity and code quality (in that order).

::right::

<img src="/images/photo.jpg" class="photo">

<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->

<style>
h1 {
  background-color: #2B90B6;
  background-image: linear-gradient(45deg, #4EC5D4 10%, #146b8c 20%);
  background-size: 100%;
  -webkit-background-clip: text;
  -moz-background-clip: text;
  -webkit-text-fill-color: transparent;
  -moz-text-fill-color: transparent;
}
</style>


---
transition: slide-up
layout: two-cols
level: 2
---

# Let’s talk about DevEx

It’s about removing all the roadblocks that stop you from working efficiently (also known as: bullsh*t).

The very first thing that you encounter in a new company/project is the local env setup. 

Especially important when working with Microservices.

But not only - for example, freelancers encounter this as well a lot when switching between projects. 

Did you ever come back to a project after 5 years?

I did. 

It. Is. Not. Fun.

:: right ::

<SlidevVideo v-click autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/blocks-wrecked.mp4" type="video/mp4">
</SlidevVideo>


---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8 gap-16
---

# Let’s talk about DevEx

You join a new project. Or even worse, an old one. What do you need to do?

::left::

Just starting a job at a new company?

> You will need git, docker, docker-compose, node, kubectl, vscode, company dotfiles.

Install tooling (new/old version of node?)

> Actually, it’s 4 different versions of node. And Ruby. And go. Oh, did I mention Scala? <b>It’s a Zoo out there.</b>

::right::

<SlidevVideo v-click autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/madagascar.mp4" type="video/mp4">
</SlidevVideo>


---
layout: two-cols-header
transition: slide-left
layoutClass: gap-x-8
---

# Let’s talk about DevEx

You join a new project. Or even worse, an old one. What do you need to do?

::left::

Oh no, libsass won’t compile due to old Python 

> There’s a docker-compose.yml, we are golden!

But where do I get the env variables from?

> There’s env.local.example. Copy it and fill in with your values.

It’s outdated… Also, are the database seeds loaded automatically?

> NOPE!

ALL of that work is unnecessary and a waste of your time. And puts a lot of pressure on new joiners.

::right::

<SlidevVideo v-click autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/aletter.mp4" type="video/mp4">
</SlidevVideo>


---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# Let’s solve it!
It’s simple, just create a script that installs all the required tools. Right?

::left::

<v-click>
This single team is using Scala? 

> Do we want to install Scala for everyone?
</v-click>
<br>
<v-click>
You need two different versions of OpenSSL for different projects? 

> Yeah, we can’t have that
</v-click>
<br>
<v-click>
Coming back after a year or two? 

> New OS X has now Python 3, so the script fails
</v-click>
<br>
<v-click>
Our new team member is using Windows? 

> Oh, we need to rewrite the script
</v-click>

::right::

<v-click>
<SlidevVideo v-click autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/oh-come-on.mp4" type="video/mp4">
</SlidevVideo>
</v-click>

---
layout: two-cols
transition: slide-up
layoutClass: gap-x-8
---

# Let’s solve it - attempt #2

Ok, how about containers?


<v-click>
1. Create a Dockerfile per project

  - Solves the pre-existing libraries / tools issue
  - No more version conflicts between projects
</v-click>

<v-click>

2. Install all tools within the container

</v-click>

<v-click>

3. Create a docker-compose.yml with services

</v-click>

<v-click>

4. Mount local files as volumes
  - Now we can use our IDE to edit files directly

</v-click>

<v-click>
5. Use .env.local + env variables in docker-compose.yml
</v-click>

<h3 v-click class="text-center" style="margin-top: 30px;">
DONE!
</h3>

::right::

<div v-click="1" v-click.hide="3">
```docker {1-16|3}{at:2}
FROM node:20-alpine

RUN apk add git diff nano zsh httpie

RUN mkdir -p /home/node/app/node_modules && \
chown -R node:node /home/node/app

WORKDIR /home/node/app
COPY package*.json ./

USER node
RUN npm install
COPY --chown=node:node . .
EXPOSE 8080

CMD [ "node", "app.js" ]

```
</div>

<div v-click="3">
```yaml {3,17-23|12-13|7,23|all}{at: 4}
version: '3'

services:
  node-app:
    build: .
    image: node-app
    env_file: ".env.local"
    ports:
      - "8080:8080"
    depends_on:
      - postgres
    volumes:
      - .:/app
    networks:
      - node-network
    command: npm run dev
  postgres:
    image: postgres:14-alpine
    ports:
      - 5432:5432
    volumes:
      - ~/apps/postgres:/var/lib/postgresql/data
    env_file: ".env.local"
```
</div>


<style>
ul {
  padding-left: 10px;
  margin-top: 5px;
  margin-bottom: 10px;
  color: #ffffffaa; 
}
.slidev-vclick-hidden .slidev-code-wrapper {
  display: none;
}

</style>


---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# Let’s solve it - attempt #2

Or are we?


1. Now all tools can be used only in the container
2. If you want them available everywhere, each container needs to have them installed
3. Adding a tool will require rebuilding everything
4. If the distribution doesn't contain a package for your tool, you are in for a lot of pain
5. Docker builds aren't really reproducible
6. We can't install GUI applications that way
7. It's not easy to use one's own shell configuration

<!-- TODO: FIXME: improve this slide --->


<style>
ul {
  padding-left: 10px;
  margin-top: 5px;
  margin-bottom: 10px;
  color: #ffffffaa; 
}
</style>



---
layout: section
transition: slide-up
layoutClass: gap-x-8
---

# We are doomed

There is no solution. We just need to suffer.

<div class="flex flex-col items-center">
<SlidevVideo autoplay loop autoreset="click" class="text-center">
    <source src="/images/fire.mp4" type="video/mp4">
</SlidevVideo>
</div>

<h4 v-click class="text-center" style="margin-top: 30px;">
Well, not really. We wouldn’t be here otherwise.
</h4>


---
layout: default
transition: slide-up
layoutClass: gap-x-8
---

# So, how does a perfect solution look like?

Let's be unreasonable. We want to have everything!

1. Single stop shop for all tools, libraries and configuration
2. Needs to be a part of project's repository
3. Reproducible builds
4. Fast setup
5. Works everywhere
6. Allows for running GUI applications
7. Doesn't cause conflicts with other projects
8. Ages slowly, like a fine wine
9. Easy to use for everyone


---
layout: two-cols-left
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# Enter Nixpkgs

What is it?

::left::

- I will be crucified for this, but basically “npm” for system packages with some really nice extra features:
reproducible builds
- declarative configuration in a single, type-safe format (Nix language)
- It uses Nix store underneath
- Over 100,000 packages available. More than Arch btw.
- Anything that you could apt-get is there: vscode, node, firefox, docker.
- There is a whole Linux distribution built around it (NixOS), but we won’t be talking about it. You can read more about it here:

 

<br><br>
Project website: https://nixos.org

YouTube VimJoyer NixOS series: [youtube.com/@vimjoyer](https://www.youtube.com/playlist?list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE)

::right::

<center>
<img src="/images/nix-logo.svg" class="nix-logo" style="display: inline; width: 200px;" alt="Nix logo">
</center>

---
layout: two-cols
transition: slide-up
layoutClass: gap-x-8
---

# So how do we use it?

It’s simple:

1. Learn the Nix language
2. Understand how modules, packages and Flakes work
3. Create your own Nix flake
4. Run single shell command:
   > <code>nix shell .#dev --command 'dev-shell'</code>
5. Launch your services 

<h4 v-click class="text-center" style="margin-top: 30px;">
I'm kidding. It's not simple...

Might not be such a bad idea,<br>if you are the only person using it. 

<b>But that’s probably not the case.</b>

</h4>


::right::

<div style="margin-top: -35px">
</div>
```nix
{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-darwin";
  in {
    packages."${system}".dev = let
      pkgs = import nixpkgs { inherit system; };
      packages = with pkgs; [
          nodejs_20
          nodePackages.npm
          postgresql_15
          nushell
      ];
    in pkgs.runCommand "dev-shell" {
      buildInputs = packages;
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      mkdir -p $out/bin/
      ln -s ${pkgs.nushell}/bin/nu $out/bin/dev-shell
      wrapProgram $out/bin/dev-shell --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '';
  };
}
```


---
layout: two-cols-left
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# devenv.sh - what is it?

It's a tool that can:

::left::

1. Manage installed software, such as node, npm, postgresql, vscode
2. Handle configuration of all installed packages
3. Define environment variables
4. Run tasks, e.g. import database seed, migrate schema
5. Manage git hooks
6. Load/Unload everything automatically by using direnv
7. Build containers out of our local environment

<v-click>
<h4 class="text-center" style="margin-top: 30px;">
All of that from a type-safe, declarative, single configuration file
</h4>
</v-click>



::right::

<center>
<img src="/images/devenv-dark-bg.svg" class="devenv-logo" style="position: relative; display: inline; width: 200px" alt="Slidev logo">
</center>


---
layout: two-cols
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# Let’s try devenv.sh

Installation & initialization:

<v-click>
1. Starting from a clean slate. Nothing is installed, just a Linux VM
</v-click>
<br><br>
<v-click>
2. Install Nix:

> sh curl https://nixos.org/nix/install | sh
</v-click>
<br>
<v-click>
3. Install devenv: 

> nix profile install --accept-flake-config nixpkgs#devenv
</v-click>
<br>
<v-click>
4. Init new project:

> devenv init

Some files were automatically created for us: <i>.envrc</i>, <i>devenv.nix</i>, <i>devenv.yaml</i>, <i>.gitignore</i>
</v-click>

::right::

<div style="position: relative">
<Asciinema src="casts/recording.rec" :playerProps="{  controls: false, theme: 'auto/dracula', preload: true, idleTimeLimit: 2}"/>
</div>

---
layout: default
transition: slide-up
layoutClass: gap-x-8
---

# It's ready. Now what?

Now we can use devenv CLI:
- <span>devenv shell</span> - enter your local environment
- <span>devenv up</span>  - start services (e.g. postgresql)
- <span>devenv test</span>  - run tests and git hooks
- <span>devenv update</span>  - update your packages and save lockfile
- <span>devenv gc</span>  - clean unused packages




<h4 v-click class="text-center" style="margin-top: 30px;">
Wait, but there is no <span>devenv install</span>. How do I add a package???
</h4>

<style>
span {
  display: inline-block;
  padding: 0 10px;
  font-size: 14px;
  color: gray;
  background: rgba(255,255,255,0.1);
}
li {
margin-top: 3px;
}
</style>




---
layout: two-cols
transition: slide-up
layoutClass: gap-x-8
---

# Use the config, Luke

Everything you need is in the devenv.nix file

Wait, that’s all? 

> Yes, as long as you want Node.js.

<br>
<v-click>
What about bun?

> No problem!
</v-click>

<br>

<v-click at="4">

> Now we can execute <span>devenv shell</span> and have everything set up for us.<br><br> 
> Try executing <span>node --version</span>, <span>bun --version</span> or <span>npm --version</span>

</v-click>


::right::

````md magic-move 
<<< @/snippets/devenv.nix#languages nix
<<< @/snippets/devenv.nix#bun nix {5}
````
<br>

<div style="position: relative">
<Asciinema src="casts/recording.rec" :playerProps="{ startAt: '1:43', autoPlay: false, controls: true, theme: 'auto/dracula', preload: true}"/>
</div>

<style>
.ap-terminal {
  border-color: transparent !important;
  border-width: 0 !important;
  background: rgba(0,0,0,0.5);
}

span {
  display: inline-block;
  padding: 0 10px;
  font-size: 14px;
  color: gray;
  background: rgba(255,255,255,0.1);
}
</style>



---
layout: default
transition: slide-up
layoutClass: gap-x-8
---

# Let’s add some env variables...

It's just another option in devenv.nix:

<div style="width: 700px;">
<<< @/snippets/devenv.nix#env nix

</div>
<br>

<img src="/images/env.png" style="width: 700px;"/>



---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# ...and services,

There are plenty of predefined ones:


::left::

<img src="/images/services.png" style="min-width:450px"/>

::right::

<div style="max-width: 100%">

<<< @/snippets/devenv.nix#services nix 

</div>


---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# ...and hooks with linters.

devenv.sh supports many of them out of the box:

::left::
<<< @/snippets/devenv.nix#hooks nix



::right::

<img src="/images/hooks.png" style="width: 700px;"/>





---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# What about database migrations?

We can create arbitrary tasks and define when they run:

::left::

<div style="margin-top: -100px"></div>

<<< @/snippets/devenv.nix#tasks nix

::right::


<div style="margin-top: -100px"></div>

<img src="/images/tasks.png" style="width: 700px;"/>


---
layout: section
transition: slide-up
layoutClass: gap-x-8
---

# Well, that was easy!

Doomsday avoided. Our local env is amazing now.

<br>
<div class="flex flex-col items-center" style="width:400px; margin: auto;">
<SlidevVideo autoplay loop autoreset="click" class="text-center">
    <source src="/images/easy.mp4" type="video/mp4">
</SlidevVideo>
</div>

<h4 v-click class="text-center" style="margin-top: 30px;">
Questions?
</h4>



