{ pkgs, ... }:
{
	# Nix
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
	};
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};

	# Boot
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	# Locale
	time.timeZone = "Europe/London";
	i18n.defaultLocale = "en_GB.UTF-8";
	console.keyMap = "uk";

	# User
	users.users.atlas = {
		isNormalUser = true;
		description = "Atlas";
		extraGroups = [ "wheel" "video" "audio" "input" "networkmanager" ];
		shell = pkgs.bashInteractive;
	};

	# Packages
	environment.systemPackages = with pkgs; [
		git btop nano fastfetch
	];

	# Maintenance
	services = {
		fstrim.enable = true;
		fwupd.enable = true;
		openssh.enable = false;
		printing.enable = false;
		avahi.enable = false;
	};

	# Memory
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 25;
		priority = 100;
	};
}
