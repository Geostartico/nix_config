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
		xfce.thunar
		#v4l2loopback
		(wrapOBS {
		    plugins = with obs-studio-plugins; [
		      wlrobs
		      obs-pipewire-audio-capture
		    ];
		  })
	];
	services.gnome.gnome-keyring.enable = true;
	programs.river-classic.enable = true;
	programs.river-classic.xwayland.enable = true;
	services.dbus.enable = true;
	environment.sessionVariables = {
		XDG_CURRENT_DESKTOP = "river";
		XDG_SESSION_DESKTOP = "river";
		XDG_SESSION_TYPE = "wayland";
	};
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
		wlr.enable = true;
	        config = {
			common = {
			  default = [ "wlr" "gtk" ];
			};
			river = {
			  default = [ "wlr" "gtk" ];
			};
		};
		#config = {
		#	common = {
		#		default = [ "wlr" ]; # Set preferred portal
		#	};
		#};
	};
	#systemd.user.services.xdg-desktop-portal-gtk = {
	#	enable=true;
	#	environment = {
	#		DISPLAY=":0";
	#	};
	#};
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
	boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
	boot.kernelModules = [ "v4l2loopback" ];

	# Configure v4l2loopback
	boot.extraModprobeConfig = ''
	  options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
	'';
}

