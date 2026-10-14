{ lib, ... }:
{
	# Modules
	imports = [
		./hardware-configuration.nix
		../../modules/base.nix
		../../modules/desktop.nix
		../../modules/gaming.nix
		../../modules/networking.nix
	];

	# System
	networking.hostName = "desktop";
	system.stateVersion = "26.05";

	# Graphics
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
	boot.kernelParams = [ "amd_pstate=active" ];

	# Memory
	swapDevices = lib.mkForce [ ];
}
