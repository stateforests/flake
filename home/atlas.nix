{ pkgs, inputs, lib, ... }:

let
	configDir = ../config;

	mkConfigFiles =
		dir:
		let
			entries = builtins.readDir dir;
		in
		lib.concatMapAttrs (
			name: type:
			let
				path = dir + "/${name}";
				rel = lib.removePrefix "${toString configDir}/" (toString path);
			in
			if type == "directory" then mkConfigFiles path
			else { "${rel}".source = path; }
		) entries;
in {
	# Modules
	imports = [ ./river.nix ./persist.nix ];

	# Home
	home = {
		username = "atlas";
		homeDirectory = "/home/atlas";
		stateVersion = "26.05";
		packages = [ inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default ];
	};

	# Programs
	programs.home-manager.enable = true;
	programs.bash = {
		enable = true;
		enableCompletion = true;
		historyControl = [ "ignoredups" "ignorespace" ];
	};
	programs.git.enable = true;

	# Config
	xdg = {
		enable = true;
		configFile = mkConfigFiles configDir;
	};

	# Notifications
	services.mako = {
		enable = true;
		settings = {
			background-color = "#000000";
			text-color = "#ffffff";
			border-color = "#444444";
			border-size = 1;
			border-radius = 0;
			padding = "8";
			default-timeout = 5000;
		};
	};
}
