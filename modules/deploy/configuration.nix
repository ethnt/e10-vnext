{ self, inputs, ... }:
let
  inherit (self.lib.colmena) mkNode metaFor;
  l = inputs.nixpkgs.lib // builtins;

  configurations = l.removeAttrs self.nixosConfigurations [ ];

  mkNode' = n: mkNode configurations.${n} n;

  mkHive = nodes:
    (l.mapAttrs mkNode' nodes)
    // (metaFor (l.intersectAttrs nodes configurations));
in { flake.colmena = mkHive { gateway = { tags = [ "@web" "@aws" ]; }; }; }