  { inputs, outputs, lib, config, pkgs, ... }:
  
  {
  imports =
  [ # Include the results of the hardware scan.							
    ./hardware-configuration.nix
  ];
  
  # System boot sections
  boot = {
    supportedFilesystems = [ "ntfs" "bcachefs" ];		# Supported file systems
    kernel.sysctl."net.ipv4.ip_default_ttl" = 65;		# Sync TTL to mobile
    loader = {																				
  	  systemd-boot.enable = true;										# Systemd-boot loader config
  	  timeout = 10;																	# Linux boot section timeout
  	  efi.canTouchEfiVariables = true;
    };
  };
  
  # Nix configuration
  nix.settings = {
  	auto-optimise-store = true;   																															# Store optimization	
  	experimental-features = [ "nix-command" "flakes" ]; 																				# Enable flakes
  	#registry = lib.mapAttrs (_: value: { flake = value; }) inputs;                             # To make nix3 commands consistent with your flake
  	#nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;  # This will additionally add your inputs to the system's legacy channels
  };
  
  
  # Define your hostname.
  networking = {
    hostName = "nixos-ulad";
    networkmanager.enable = true;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };
  
  # Set your time zone.
  time = {
    timeZone = "Europe/Istanbul";
  };
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
  	LC_ADDRESS = "eo";
  	LC_IDENTIFICATION = "eo";
  	LC_MEASUREMENT = "eo";
  	LC_MONETARY = "eo";
  	LC_NAME = "eo";
  	LC_NUMERIC = "eo";
  	LC_PAPER = "eo";
  	LC_TELEPHONE = "eo";
  	LC_TIME = "eo";
  };
  console = {
  	font = "JetBrains Mono";
  	keyMap = "us";
  };
  
  # Global services configuration
  services = {
  
  	# Environment configuration	  
  	xserver = {
  		enable = true;
  
  		# Dekstop Manager
  		desktopManager = {
  			plasma5 = {
  				enable = true;
  			};
  		};
  				
  		# Display Manager
  		displayManager = {
  			sddm = {
  				enable = true;
  				autoNumlock = true;
  			};
  			defaultSession = "plasmawayland";
  		};
  	
  		# Language sesttings
  		layout = "us,ru";
  		xkbOptions = "grp:win_space_toggle";
  						
  		# Touchpad  & mouse config
  		libinput = {
  			enable = true;
  		};
    };
          
  	# Sound services configuration
  	pipewire = {
  		enable = true;							# Pipewire support
  		alsa = {										# Alsa support
  			enable = true;
  			support32Bit = true;
  		};
  		pulse.enable = true;				# PulseAudio support
  	};
  	
  	printing.enable = true; 			# Printing services
  	mullvad-vpn.enable = true; 		# MullvadVPN support
  	openssh.enable = true; 				# Enable the OpenSSH daemon.
  	flatpak.enable = false; 			# Flatpak support
  };
  
  # Global hardware configuration
  hardware = {
  
  	# Opengl & Vulkan support
  	opengl = {
  		enable = true;
  		driSupport = true;
  		driSupport32Bit = true;
  	};
  	
  	# Pulseaudio hardware access
  	pulseaudio.enable = false;
  	
  	# Razer mouse notification
  	openrazer.enable = true;
  	
  	# Bluetooth support
  	bluetooth = {
  	  enable = true;
  	};	
  };
  
  sound.enable = true;					# Enable sound.
  security = {
  	rtkit.enable = true;
  	polkit.enable = true;
  	sudo.enable = true;
  	doas = {
  		enable = false;
  		extraRules = [{
        users = [ "ulad" ];
        keepEnv = true;
        persist = true;  
  		}];
  	};
  };
  
  
  users = {
  
    # Declarative configuration for users
    mutableUsers = false;
          
    # Current user
    users.ulad = {
      isNormalUser = true;
      description = "Ulad";
        extraGroups = [ 
          "wheel"
          "users" 
          "adbusers"
          "networkmanager"
          "video"
          "audio"
          "aria2"
          "openrazer"
          "plugdev"
          "transmission"
          ];
      password = " ";
    };
  };      
  
  qt = {
  	enable = true;
  	platformTheme = "kde";
  };
  
  system.stateVersion = "23.05";
  }
  
