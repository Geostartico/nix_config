{
  description = "initial flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rustup-toolchain.url = "path:/home/geostartico/Code/rust";
  };

  outputs = { self, nixpkgs,rustup-toolchain,  ...}@inputs: {
	    nixosConfigurations.geostartico = nixpkgs.lib.nixosSystem {
	      system = "x86_64-linux";
	      specialArgs = {inherit inputs;};
	      modules = [ 
		      ./configuration.nix
		      #{
		      #	environment.systemPackages = [
		      #  	              rust-toolchain.devShells.${self.system}.rust-shell
		      #  ];
		      #}
	      ];
	    };
	    devShells.x86_64-linux.rust-shell = rustup-toolchain.devShells.x86_64-linux.default;
  };

}
