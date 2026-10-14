{ pkgs, ... }:
{

	# Audio
	services.pipewire = {
		enable = true;
		alsa = { enable = true; support32Bit = true; };
		pulse.enable = true;
		wireplumber.enable = true;
	};
	security = {
		rtkit.enable = true;
		polkit.enable = true;
	};

	# Portals
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
		config.common.default = [ "wlr" "gtk" ];
	};

	# Compatibility
	programs.nix-ld.enable = true;
	programs.appimage = {
		enable = true;
		binfmt = true;
	};

	# River
	programs.river-classic = {
		enable = true;
		xwayland.enable = true;
		extraPackages = [ ];
	};

	# VPN
	services.mullvad-vpn = {
		enable = true;
		gui.enable = true;
	};

	# Desktop
	programs.gpu-screen-recorder.enable = true;
	environment.systemPackages = with pkgs; [
		rivertile
		foot fuzzel waybar mako waylock
		wl-clipboard cliphist grim slurp
		networkmanagerapplet lxqt.lxqt-policykit
		dolphin kate pavucontrol
		keepassxc signal-desktop
		obs-studio gpu-screen-recorder
		adwaita-icon-theme hicolor-icon-theme
	];

	# Greeter
	programs.regreet = {
		enable = true;
		extraCss = ''
			window {
				background: #000000;
				color: #ffffff;
			}

			entry, button, combobox {
				border-radius: 0;
			}
		'';
	};

	# Session
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		MOZ_ENABLE_WAYLAND = "1";
		QT_QPA_PLATFORM = "wayland";
		XDG_CURRENT_DESKTOP = "river";
		XCURSOR_THEME = "Adwaita";
		XCURSOR_SIZE = "24";
	};
}
