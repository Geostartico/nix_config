# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		grim
		slurp
		wl-clipboard
		mako
		weston
		wlr-randr
		river-bsp-layout
	];
	services.gnome.gnome-keyring.enable = true;
	programs.river.enable = true;
	programs.river.xwayland.enable = true;
	services.displayManager = {
		enable = true;
		sddm = {
			enable = true;
			wayland.enable = true;
			wayland.compositor =  "weston";
		};
	};
}

