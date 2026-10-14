{ ... }:
{
	wayland.windowManager.river = {
		enable = true;
		package = null;
		xwayland.enable = true;

		# Appearance
		settings = {
			background-color = "0x000000";
			border-width = 1;
			border-color-focused = "0xd8d8d8";
			border-color-unfocused = "0x101010";
			border-color-urgent = "0xff5555";

			# Focus
			focus-follows-cursor = "normal";
			set-cursor-warp = "disabled";

			# Behaviour
			set-repeat = "25 200";
			default-attach-mode = "bottom";
			default-layout = "rivertile";

			# Keybinds
			map.normal = {
				"Alt Return" = "spawn foot";
				"Alt D" = "spawn fuzzel";
				"Alt Q" = "close";
				"Alt F" = "toggle-fullscreen";
				"Alt+Shift Space" = "toggle-float";

				"Alt 1" = "set-focused-tags 1";   "Alt+Shift 1" = "set-view-tags 1";
				"Alt 2" = "set-focused-tags 2";   "Alt+Shift 2" = "set-view-tags 2";
				"Alt 3" = "set-focused-tags 4";   "Alt+Shift 3" = "set-view-tags 4";
				"Alt 4" = "set-focused-tags 8";   "Alt+Shift 4" = "set-view-tags 8";
				"Alt 5" = "set-focused-tags 16";  "Alt+Shift 5" = "set-view-tags 16";
				"Alt 6" = "set-focused-tags 32";  "Alt+Shift 6" = "set-view-tags 32";
				"Alt 7" = "set-focused-tags 64";  "Alt+Shift 7" = "set-view-tags 64";
				"Alt 8" = "set-focused-tags 128"; "Alt+Shift 8" = "set-view-tags 128";
				"Alt 9" = "set-focused-tags 256"; "Alt+Shift 9" = "set-view-tags 256";

				"None Print" = "spawn 'grim - | wl-copy'";
				"Shift Print" = "spawn 'grim -g \"$(slurp)\" - | wl-copy'";
				"None XF86AudioRaiseVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'";
				"None XF86AudioLowerVolume" = "spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
				"None XF86AudioMute" = "spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
			};

			# Pointer
			map-pointer.normal = {
				"Alt BTN_LEFT" = "move-view";
				"Alt BTN_RIGHT" = "resize-view";
			};

			# Rules
			rule-add = [
				"-title 'Picture-in-Picture' float"
				"-title '*Open File*' float"
				"-title '*Save File*' float"
				"-title '*Preferences*' float"
				"-app-id steam -title '*Friends*' float"
				"-app-id steam -title '*Chat*' float"
				"ssd"
			];
		};

		# Startup
		extraConfig = ''
			rivertile -view-padding 0 -outer-padding 0 &
			nm-applet --indicator &
			lxqt-policykit-agent &
			wl-paste --type text --watch cliphist store &
			wl-paste --type image --watch cliphist store &
			waybar &
		'';
	};
}
