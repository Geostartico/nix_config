# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
#List packages installed in system profile. To search, run: $ nix search wget
environment.systemPackages = with pkgs; [ grim
		slurp
		wl-clipboard
		mako
		weston
		wlr-randr
		river-bsp-layout
		xdg-desktop-portal
		xdg-desktop-portal-wlr
		xdg-desktop-portal-gtk
	];
	services.gnome.gnome-keyring.enable = true;
	programs.river.enable = true;
	programs.river.xwayland.enable = true;
	services.dbus.enable = true;
	environment.sessionVariables = {
		XDG_CURRENT_DESKTOP = "river";
		XDG_SESSION_DESKTOP = "river";
		XDG_SESSION_TYPE = "wayland";
	};
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
		config = {
			common = {
				default = [ "wlr" ]; # Set preferred portal
			};
		};
	};
	systemd.user.services.xdg-desktop-portal-gtk = {
		enable=true;
		environment = {
			DISPLAY=":0";
		};
	};
	systemd.user.services.xdg-desktop-portal-wlr = {
		environment = {
			WAYLAND_DISPLAY="wayland-1";
		};
		enable = true;
		wantedBy = [ "multi-user.target" ];
		after = [ "network.target" ];  # Ensures it starts after the Wayland session is up
		serviceConfig = {
			ExecStart = "${pkgs.bash}/bin/bash -c 'echo Starting my service; /path/to/your/service/executable'";
			ExecStartPre = "${pkgs.coreutils}/bin/sleep 1"; # Delay of 10 seconds before starting the service
		};

	};
	services.displayManager = {
		enable = true;
		sddm = {
			enable = true;
			wayland.enable = true;
			wayland.compositor =  "weston";
		};
	};
}

