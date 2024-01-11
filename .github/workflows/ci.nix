{
  name = "CI";
  on = { push = { }; };
  jobs = {
    check = {
      "runs-on" = "ubuntu-latest";
      steps = [
        {
          name = "Checkout code";
          uses = "actions/checkout@v3";
        }
        {
          name = "Install Nix";
          uses = "cachix/install-nix-action@v22";
          "with" = {
            extra_nix_config = ''
              allow-import-from-derivation = true;
            '';
            nix_path = "nixpkgs=channel:nixos-unstable";
          };
        }
        {
          name = "Use Cachix store";
          uses = "cachix/cachix-action@v12";
          "with" = {
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            extraPullNames = "e10,nix-community";
            name = "e10";
          };
        }
        {
          run = ''
            nix flake check --impure --show-trace
          '';
        }
      ];
    };
  };
}

