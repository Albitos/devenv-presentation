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



<!--
1:00

Hello! I'm Witold and I'm a Team Lead at monday.com. 
I have an obsession with productivity and one of the things that I find the most annoying is setting up a local environment.
During this talk I will show you how you can quickly do it in a best possible way using Nix and devenv.sh
 
-->

---
transition: slide-up
layout: two-cols-header
level: 2
---

# Let’s talk about DevEx

It’s about removing all the roadblocks that stop you from working efficiently (also known as: bullsh*t).

::left::
The very first thing that you encounter at a new company/project is the local env setup. 

Especially important when working with Microservices.

But not only - for example, freelancers encounter this as well a lot when switching between projects. 

Did you ever come back to a project after 5 years?

<v-click>
I did. 

It. Is. Not. Fun.
</v-click>

::right::

<SlidevVideo v-click="1" autoplay loop autoreset="click" style="max-height: 400px; width: 100%;">
    <source src="/images/blocks-wrecked.mp4" type="video/mp4">
</SlidevVideo>

<!--
It’s about removing all the roadblocks that stop you from working efficiently (also known as: bullsh*t).

The very first thing that you encounter at a new company/project is the local env setup. 

It's important to have as little roadblocks as possible

Especially important when working with Microservices.

But not only - for example, freelancers encounter this as well a lot when switching between projects. 

Did you ever come back to a project after 5 years?

<PAUSE + CLICK>

[click] I did. 

It. Is. Not. Fun.

Let's see how it usually looks like:
-->

---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8 gap-16
---

# Let’s talk about DevEx

Just starting a job at a new company?


::left::

<div style="margin-top:-60px;"/>

You will need to set up your machine:

1. Install general tools: git, docker, etc.

2. Install runtimes / libraries:

<v-clicks>  

   - NodeJS

   - Actually, it’s 4 different versions of node.

   - And Ruby.

   - And Go.

   - Oh, did I mention Scala?

 </v-clicks> 

<v-click><b>It’s a Zoo out there.</b></v-click>

::right::

<div style="margin-top:-45px;"/>

<SlidevVideo v-click="6" autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/madagascar.mp4" type="video/mp4">
</SlidevVideo>

<style>
ul li {
    position: relative;
    left: 20px;
}
ul li p {
  margin-top: 3px !important;
  line-height: 1rem;
}
b {
  margin-top: 2rem;
  display: block;
}
</style>

<!--
<b>Let’s talk about DevEx</b>

Just starting a job at a new company? You will need to set up your machine:

1. Install general tools: git, docker, etc.

2. Install runtimes / libraries:

[click] NodeJS<br> 
[click] Actually, it’s 4 different versions of node.<br>
[click] And Ruby.<br>
[click] And Go.<br>
[click] Oh, did I mention Scala?<br>

< PAUSE >

[click] <b>It’s a Zoo out there.</b>

-->

---
layout: two-cols-header
transition: slide-left
layoutClass: gap-x-8
---

# Let’s talk about DevEx

You join a new project. Or even worse, an old one. How does that look like?

::left::

<v-click>
Oh no, libsass won’t compile due to old Python 

> Found a solution on the company Wiki. 2 hours gone.

</v-click>
<br>
<v-click>
But where do I get the env variables from?

> There’s env.local.example. Copy it and fill in with your values.

</v-click>
<br>
<v-click>
It’s outdated… 

> Asked a coworker. It took until next day as they had meetings.

</v-click>
<br>
<v-click>
Also, are the database seeds loaded automatically?

> NOPE! Need to run a script. Another 2 hours gone.

</v-click>
<br>
<v-click>

<strong>ALL of that work is unnecessary</strong> and wastes time!

</v-click>

::right::

<SlidevVideo v-click="5" autoplay loop autoreset="click" style="width: 100%;">
<source src="/images/aletter.mp4" type="video/mp4">
</SlidevVideo>

<!--
3:00

So we have the machine set up.

You join a new project. Or even worse, an old one. 

How does that look like?

[click] Oh no, libsass won’t compile due to old Python 
> Found a solution on the company Wiki. 2 hours gone.

[click] But where do I get the env variables from?

> There’s env.local.example. Copy it and fill in with your values.

[click] It’s outdated… 
> Asked a coworker. It took until next day as they had meetings.

[click] Also, are the database seeds loaded automatically?
> NOPE! Need to run a script. Another 2 hours gone.

[click] <strong>ALL of that work is unnecessary</strong> and wastes time! 

It's <strong>frustrating</strong>



-->

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

> <b>Oh come on</b>, we need to rewrite the script
</v-click>

::right::

<SlidevVideo v-click="4" autoplay loop autoreset="click" style="width: 100%;">
    <source src="/images/oh-come-on.mp4" type="video/mp4">
</SlidevVideo>



<!--

<strong>Let’s solve it!</strong>: It’s simple, just create a script that installs all the required tools. Right?

[click] This single team is using Scala? Do we want to install Scala for everyone? 

**Problem:** you would need script per team or maintain every setup.

[click] You need two different versions of OpenSSL for different projects? Yeah, we can’t have that 

**Problem:** Handling multiple versions of the same tool is hard

[click] Coming back after a year or two? New OS X has now Python 3, so the script fails 

**Problem:** coming back after some time, the script might not work due to the system changes

< PAUSE >

[click]  Our new team member is using Windows? <b>Oh come on</b>, we need to rewrite the script 


**Problem:** It's hard to make sure that a manually written script works correctly everywhere. Every OS handles software installation differently.

< MEM >

-->

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


<!--

<strong>Let’s solve it - attempt #2</strong>

Ok, how about containers?

[click] 1. Create a Dockerfile per project
  - Solves the pre-existing libraries / tools issue
  - No more version conflicts between projects

[click] 2. Install all tools within the container

[click] 3. Create a docker-compose.yml with services

[click] 4. Mount local files as volumes
  - Now we can use our IDE to edit files directly

[click] 5. Use .env.local + env variables in docker-compose.yml

[click] DONE! Or are we?

-->


---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# Let’s solve it - attempt #2

Or are we?


<v-click>
<p>1. Now all tools can be used only in the container</p>
</v-click>

<v-click>
<p>2. If you want them available everywhere, each container needs to have them installed</p>
</v-click>

<v-click>
<p>3. Adding a tool will require rebuilding everything</p>
</v-click>

<v-click>
<p>4. If the distribution doesn't contain a package for your tool, you are in for a lot of pain</p>
</v-click>

<v-click>
<p>5. Docker builds aren't really reproducible</p>
</v-click>

<v-click>
<p>6. We can't install GUI applications that way</p>
</v-click>

<v-click>
<p>7. It's not easy to use one's own shell configuration</p>
</v-click>


<style>
br {
  margin-bottom: 0.5em !important;
  display: block !important;
}
</style>

<!--


[click] 1. Now all tools can be used only in the container

[click] 2. If you want them available everywhere, each container needs to have them installed

[click] 3. Adding a tool will require rebuilding everything

[click] 4. If the distribution doesn't contain a package for your tool, you are in for a lot of pain

[click] 5. Docker builds aren't really reproducible

[click] 6. We can't install GUI applications that way

[click] 7. It's not easy to use one's own shell configuration

-->

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


<!--


# We are doomed

There is no solution. We just need to suffer.

<div class="flex flex-col items-center">
<SlidevVideo autoplay loop autoreset="click" class="text-center">
    <source src="/images/fire.mp4" type="video/mp4">
</SlidevVideo>
</div>

[click] <h4 class="text-center" style="margin-top: 30px;">
Well, not really. We wouldn’t be here otherwise.
</h4>


-->

---
layout: two-cols-header
transition: slide-up
layoutClass: gap-x-8
---

# So, how does a perfect solution look like?

Let's be unreasonable. We want to have everything!


::left::

<p>
1. Single stop shop for all tools, libraries and configuration
</p>

<v-click>
<p>
2. Needs to be a part of project's repository
</p>
</v-click>

<v-click>
<p>
3. Reproducible builds
</p>
</v-click>

<v-click>
<p>
4. Fast setup
</p>
</v-click>

<v-click>
<p>
5. Works everywhere
</p>
</v-click>

<v-click>
<p>
6. Allows for running GUI applications
</p>
</v-click>

<v-click>
<p>
7. Doesn't cause conflicts with other projects
</p>
</v-click>

<v-click>
<p>
8. Ages slowly, like a fine wine
</p>
</v-click>

<v-click>
<p>
9. Easy to use for everyone
</p>
</v-click>

::right::


<SlidevVideo autoplay loop autoreset="click" style="max-height: 400px; width: 100%;">
    <source src="/images/daydream.mp4" type="video/mp4">
</SlidevVideo>


<!--

So, how does a perfect solution look like?

1. Single stop shop for all tools, libraries and configuration

[click] 2. Needs to be a part of project's repository

[click] 3. Reproducible builds

[click] 4. Fast setup

[click] 5. Works everywhere

[click] 6. Allows for running GUI applications

[click] 7. Doesn't cause conflicts with other projects

[click] 8. Ages slowly, like a fine wine

[click] 9. Easy to use for everyone


-->


---
layout: two-cols-left
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# Enter Nixpkgs

What is it?

::left::

Basically “npm” for system packages with a few twists:
- over 100,000 packages available. More than Arch btw.
- declarative configuration in a single, type-safe format (Nix language)
- reproducible builds
- ability to install multiple versions of the same package
- There is a whole Linux distribution built around it (NixOS), but we won’t be talking about it. You can read more about it here:

<br><br>
Project website: https://nixos.org

YouTube VimJoyer NixOS series: [youtube.com/@vimjoyer](https://www.youtube.com/playlist?list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE)

::right::

<center>
<img src="/images/nix-logo.svg" class="nix-logo" style="display: inline; width: 200px;" alt="Nix logo">
</center>

<!--


I will be crucified for this, but basically “npm” with a few twists:

- Over 100,000 packages available. More than Arch btw.: Anything that you could apt-get is there: vscode, node, firefox, docker.

- declarative configuration in a single, type-safe format (Nix language)

- reproducible builds: devenv.lock and flakes

- ability to install multiple versions of the same package: It uses Nix store underneath

- There is a whole Linux distribution built around it (NixOS), but we won’t be talking about it. You can read more about it here:

 
-->


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


<!--

# So how do we use it?

It’s simple:

1. Learn the Nix language
2. Understand how modules, packages and Flakes work
3. Create your own Nix flake
4. Run single shell command:
   > <code>nix shell .#dev --command 'dev-shell'</code>
5. Launch your services 

[click] <h4  class="text-center" style="margin-top: 30px;">
I'm kidding. It's not simple...

Might not be such a bad idea,<br>if you are the only person using it. 

<b>But that’s probably not the case.</b>


-->

---
layout: two-cols-left
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# devenv.sh - what is it?

It's a tool that can:

::left::


<v-click>
<p>
1. Manage installed software, such as node, npm, postgresql, vscode
</p>
</v-click>

<v-click>
<p>
2. Handle configuration of all installed packages
</p>
</v-click>

<v-click>
<p>
3. Define environment variables
</p>
</v-click>

<v-click>
<p>
4. Run tasks, e.g. import database seed, migrate schema
</p>
</v-click>

<v-click>
<p>
5. Manage git hooks
</p>
</v-click>

<v-click>
<p>
6. Load/Unload everything automatically by using direnv
</p>
</v-click>

<v-click>
<p>
7. Build containers out of our local environment
</p>
</v-click>

<v-click>
<h4 class="text-center" style="margin-top: 30px;">
All of that from a type-safe, declarative, single configuration file
</h4>
</v-click>



::right::

<center>
<img src="/images/devenv-dark-bg.svg" class="devenv-logo" style="position: relative; display: inline; width: 200px" alt="Slidev logo">
</center>


<!--


devenv.sh - what is it?

It's a tool that can:


[click] 1. Manage installed software, such as node, npm, postgresql, vscode

[click] 2. Handle configuration of all installed packages

[click] 3. Define environment variables

[click] 4. Run tasks, e.g import database seed, migrate schema

[click] 5. Manage git hooks

[click] 6. Load/Unload everything automatically by using direnv

[click] 7. Build containers out of our local environment

[click] <h4 class="text-center" style="margin-top: 30px;">
All of that from a type-safe, declarative, single configuration file
</h4>


-->


---
layout: two-cols
transition: slide-up
leftColSpan: 7
layoutClass: gap-x-8
---

# Let’s try devenv.sh

Installation & initialization:

1. Starting from a clean slate. Nothing is installed, just a Linux VM
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


<SlidevVideo autoplay loop autoreset="click" timestamp="4" style="width: 100%;">
    <source src="/casts/devenv.mp4" type="video/mp4">
</SlidevVideo>

</div>

<!--

Let’s try devenv.sh

Installation & initialization:

1. Starting from a clean slate. Nothing is installed, just a Linux VM

[click] 2. Install Nix:

> sh curl https://nixos.org/nix/install | sh

[click] 3. Install devenv: 

> nix profile install --accept-flake-config nixpkgs#devenv

[click] 4. Init new project:

> devenv init

Some files were automatically created for us: <i>.envrc</i>, <i>devenv.nix</i>, <i>devenv.yaml</i>, <i>.gitignore</i>
</v-click>

-->



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

<!--

# It's ready. Now what?

Now we can use devenv CLI:
- <span>devenv shell</span> - enter your local environment
- <span>devenv up</span>  - start services (e.g. postgresql)
- <span>devenv test</span>  - run tests and git hooks
- <span>devenv update</span>  - update your packages and save lockfile
- <span>devenv gc</span>  - clean unused packages

[click] <h4 class="text-center" style="margin-top: 30px;">
Wait, but there is no <span>devenv install</span>. How do I add a package???
</h4>

-->


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
<v-click at="1">
What about bun?

> No problem!
</v-click>

<br>

<v-click at="2">

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
<SlidevVideo autoplay loop autoreset="click" timestamp="103" style="width: 100%;">
    <source src="/casts/devenv.mp4#t=103" type="video/mp4">
</SlidevVideo>
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

<!--

# Use the config, Luke

Everything you need is in the devenv.nix file

Wait, that’s all? 

> Yes, as long as you want Node.js.

[click] What about bun?

> No problem!

[click]
> Now we can execute <span>devenv shell</span> and have everything set up for us.<br><br> 
> Try executing <span>node --version</span>, <span>bun --version</span> or <span>npm --version</span>

-->

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

<!--
# Let’s add some env variables...

It's just another option in devenv.nix:

```
env = {
  NODE_ENV = "development";
  DB_CONNECTION_STRING = "postgres://myuser:pass@127.0.0.1:15432/mydb";
  NODE_PATH = "./my-app/node_modules";
};

```
-->

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

<!--
# ...and services,

There are plenty of predefined ones:


<div style="font-size: 14px">

```
 services.postgres = {
   enable = true;
   listen_addresses = "127.0.0.1";
   port = 15432; # We alrady have another postgresql instance running locally.
   package = pkgs.postgresql_15;
   initialDatabases = [{ name = "mydb"; schema = ./seeds/database.sql; pass = "pass"; user = "myuser"; }];
   extensions = extensions: [
     extensions.postgis
     extensions.pgvector
   ];
   settings.shared_preload_libraries = "vector";
   initialScript = "CREATE EXTENSION IF NOT EXISTS vector;";
};
```
</div>
-->

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


<!--

# ...and hooks with linters.

devenv.sh supports many of them out of the box:
- eslint
- prettier
- secret detection
- stylelint

-->


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

<!--
### What about database migrations?
We can create arbitrary tasks and define when they run:
```
tasks."app:migrate" = {
  exec = ''
      cd my-app
      npx sequelize db:migrate
  '';
  after = [ "devenv:enterShell" ];
  before = [ "devenv:enterTest" ];
};
```
-->

---
layout: section
transition: slide-up
layoutClass: gap-x-8
---

# Well, that was easy!

Doomsday avoided. Our local env is amazing now.

<br>
<div class="flex flex-col items-center" style="width:400px; margin: auto;">

<SlidevVideo autoplay loop autoreset="click" style="max-height: 400px; width: 100%;">
    <source src="/images/easy.mp4" type="video/mp4">
</SlidevVideo>
</div>

<h4 v-click class="text-center" style="margin-top: 30px;">
Questions?
</h4>

::bottom::

https://devenv.pages.wito.dev/
