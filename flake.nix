{
	description = "Atlas' NixOS configuration";

	# Inputs
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		helium = {
			url = "github:oxcl/nix-flake-helium-browser";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		mcsr-nixos = {
			url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	# Systems
	outputs = inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };

			modules = [
				./hosts/desktop
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; };
					home-manager.users.atlas = import ./home/atlas.nix;
				}
			];
		};
	};
}
