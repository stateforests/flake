{ config, lib, pkgs, ... }:

let
	home = config.home.homeDirectory;
	persist = "${home}/persist";

	paths = {
		".config/helium" = "config/helium";
		".config/vesktop" = "config/vesktop";
		".local/share/PrismLauncher" = "share/PrismLauncher";
		".local/share/Steam/config" = "share/Steam/config";
	};

	migrate = live: saved: ''
		live=${lib.escapeShellArg "${home}/${live}"}
		saved=${lib.escapeShellArg "${persist}/${saved}"}

		${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$saved")"
		${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$live")"

		if [ -L "$live" ]; then
			${pkgs.coreutils}/bin/rm "$live"
		elif [ -e "$live" ] && [ ! -e "$saved" ]; then
			${pkgs.coreutils}/bin/mv "$live" "$saved"
		fi

		[ -e "$saved" ] || ${pkgs.coreutils}/bin/mkdir -p "$saved"
		${pkgs.coreutils}/bin/ln -sfn "$saved" "$live"
	'';
in {
	# Persistent state
	home.activation.persistAppState =
		lib.hm.dag.entryAfter [ "writeBoundary" ]
			(lib.concatStringsSep "\n" (lib.mapAttrsToList migrate paths));
}
