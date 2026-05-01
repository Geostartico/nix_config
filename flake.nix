{
  description = "initial flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, agenix, ... }@inputs:
  let
  pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = false; };
  in {
    nixosConfigurations = {
      geostartico = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs-unstable; };
        modules = [
          ./configuration.nix
	  agenix.nixosModules.default	
        ];
      };
    };
  };
}
