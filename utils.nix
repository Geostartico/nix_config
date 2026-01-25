# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		libnotify
		pamixer
		brightnessctl
		wtype
		grim
		sway-contrib.grimshot
	];
#	services.tlp.enable = true;
	services.libinput.touchpad.naturalScrolling = true;
	hardware.bluetooth = {
	  enable = true;
	  powerOnBoot = true;
	  settings = {
	    General = {
	      # Shows battery charge of connected devices on supported
	      # Bluetooth adapters. Defaults to 'false'.
	      Experimental = true;
	      # When enabled other devices can connect faster to us, however
	      # the tradeoff is increased power consumption. Defaults to
	      # 'false'.
	      FastConnectable = true;
	    };
	    Policy = {
	      # Enable all controllers when they are found. This includes
	      # adapters present on start as well as adapters that are plugged
	      # in later on. Defaults to 'true'.
	      AutoEnable = true;
	    };
	  };
	};
	services.blueman.enable = true;


}

