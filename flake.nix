{
  description = "FOSSOS: Free and Open Source Software for Open Science";

  inputs = {
    nullkomma.url = "https://flakehub.com/f/dataheld/nullkomma/0.1.*";
    nixpkgs.follows = "nullkomma/nixpkgs";
    maxheld = {
      url = "https://flakehub.com/f/dataheld/maxheld/*";
      inputs.nullkomma.follows = "nullkomma";
    };
  };

  outputs =
    inputs:
    inputs.nullkomma.lib.mkFlake { inherit inputs; } {
      nullkomma.brand = inputs.maxheld;
      nullkomma.quarto = {
        enable = true;
        brand.enable = true;
      };
      nullkomma.cloudflare = {
        enable = true;
        domain = "maxheld.de";
        name = "fossos";
      };
      # "BA" abbreviates Bachelor of Arts.
      nullkomma.lint.typos.default.extend-words.BA = "BA";
      # Keep CI and its dependent production deployment in one workflow.
      nullkomma.github.enable = false;
    };
}
