{
  description = "Nix-powered system configuration & dotfiles";

  inputs = {
    # Follow the latest nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sportradar packages
    srpkgs.url = "git+https://gitlab.sportradar.ag/sre/srpkgs?ref=main";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      mkDarwin = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin.nix
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          (./machines + "/${hostname}/configuration.nix")
          ({ pkgs, ... }: {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = with inputs; [
              srpkgs.overlay
            ];
          })
        ];
      };
    in
    {
      darwinConfigurations = {
        "alen-mb14pro" = mkDarwin "alen-mb14pro"; #change this
      };
    };
}
