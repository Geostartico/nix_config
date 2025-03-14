# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =   [
	];
# List packages installed in system profile. To search, run:
# $ nix search wget
 environment.systemPackages = with pkgs; [
 		nodejs_23
		libgcc
		python3Full
    (neovim.override {
      vimAlias = true;
#      configure = {
#        customRC = ''
#	${builtins.readFile ./init.vim}
#	'';
#        packages.myPlugins = with pkgs.vimPlugins; {
#          start = [ 
#	  	
#		#vim plugins
#		vimPlugins.dracula-nvim
#		vimPlugins.vim-devicons
#		vimPlugins.ultisnips
#		vimPlugins.nerdtree
#		vimPlugins.nerdcommenter
#		vimPlugins.vim-startify
#		vimPlugins.coc-nvim
#		vimPlugins.nightfox-nvim
#]; 
#          opt = [];
#        };
#      };
    }
  )
  #3d data processing
  opencv
  cmake
  gnumake
  gcc
  uv
  ];
}

