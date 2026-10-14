{ ... }:
{
	# NetworkManager
	networking.networkmanager = {
		enable = true;

		ensureProfiles = {
			environmentFiles = [ "/etc/nixos/secrets/network.env" ];

			profiles.home = {
				connection = {
					id = "home";
					type = "wifi";
					autoconnect = true;
				};
				wifi.ssid = "$HOME_WIFI_SSID";
				wifi-security = {
					key-mgmt = "wpa-psk";
					psk = "$HOME_WIFI_PSK";
				};
			};

			profiles.eduroam = {
				connection = {
					id = "eduroam";
					type = "wifi";
					autoconnect = true;
				};
				wifi.ssid = "eduroam";
				wifi-security.key-mgmt = "wpa-eap";

				"802-1x" = {
					eap = "peap";
					identity = "$EDUROAM_IDENTITY";
					password = "$EDUROAM_PASSWORD";
					phase2-auth = "mschapv2";
				};
			};
		};
	};
}
