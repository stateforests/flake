{ pkgs, inputs, ... }:
let
	mcsr = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in {
	# Steam
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = false;
		dedicatedServer.openFirewall = false;
	};
	hardware.steam-hardware.enable = true;

	# Gaming
	programs.gamemode.enable = true;
	programs.gamescope.enable = true;

	# MCSR
	environment.systemPackages = [
		(pkgs.prismlauncher.override {
				jdks = [ mcsrPkgs.graalvm-21 ];
				additionalLibs = [ 
						pkgs.libXtst
						pkgs.libXext
						pkgs.libX11
						pkgs.libxkbcommon
						pkgs.libxcb
						pkgs.libxt
						pkgs.libxinerama
						pkgs.jemalloc
				];
		})
		waywall
		pkgs.jemalloc
		pkgs.openjdk21
		mcsrPkgs.ninjabrain-bot
  ];

	environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';
}
