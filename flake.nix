{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      sops-nix,
      firefox-addons,
      nur,
      lib,
      ...
    }@inputs:
    let
        inherit (self) outputs;
    in
    {
      # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
      nix.registry.nixpkgs.flake = nixpkgs;
      nix.channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

      # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
      # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
      environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
      # https://github.com/NixOS/nix/issues/9574
      nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        minipc-gaming = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/um890/configuration.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.benoit = import ./homes/benoit.nix;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
              };
            }
          ];
        };
        laptop-benoit = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/pavilion14/configuration.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.benoit = import ./homes/benoit.nix;
                extraSpecialArgs = {
                  inherit inputs outputs;
                };
              };
            }
          ];
        };
      };
    };
}
