{ pkgs, ... }:
{
  packages = [
    pkgs.git
    pkgs.cowsay
  ];


  #region languages
  { pkgs, ... }: {
    languages.javascript = {
      enable = true;
      package = pkgs.nodejs;
    };
  }
  #endregion languages


  #region bun
  { pkgs, ... }: {
    languages.javascript = {
      enable = true;
      package = pkgs.nodejs;
      bun.enable = true;
    };
  }
  #endregion bun

  #region env
  env = {
    NODE_ENV = "development";
    DB_CONNECTION_STRING = "postgres://myuser:pass@127.0.0.1:15432/mydb";
    NODE_PATH = "./my-app/node_modules";
  };
  #endregion env


  #region services
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
  #endregion services

   enterTest = ''
    cd my-app
    npm run lint
  '';

  #region hooks
  packages = [
    pkgs.git
    pkgs.cowsay
  ];

  pre-commit = {
    rootSrc = ./my-app;
    hooks = {
      prettier.enable = true;
      ripsecrets.enable = true;
      eslint = {
        enable = true;
        args = ["-c" "./my-app/.eslintrc.json"];
        entry = "./my-app/node_modules/.bin/eslint";
        files = ''.*\.js$'';
      };
    };
  };
  #endregion hooks

  #region tasks
  tasks."app:migrate" = {
    exec = ''
        cd my-app
        npx sequelize db:migrate
    '';
    after = [ "devenv:enterShell" ];
    before = [ "devenv:enterTest" ];
  };
  #endregion tasks
}
