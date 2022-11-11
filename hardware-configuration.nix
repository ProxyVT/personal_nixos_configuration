# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "ohci_pci" "ehci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  
  boot.initrd.luks.devices = {
  	luksroot = {
  		device = "/dev/disk/by-uuid/9956daa0-5ff3-4f6e-91ca-ba517de46f35";
  		preLVM = true;
  	};
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
      "noatime"
      "autodefrag"
      "compress=zstd"
      ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };
    
  fileSystems."/media" =
    { device = "/dev/disk/by-label/medias";
      fsType = "ntfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  hardware.cpu.amd.updateMicrocode = true;
  #lib.mkDefault 	config.hardware.enableRedistributableFirmware;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = pkgs.linuxKernel.packages.linux_lqx.nvidia_x11_legacy470;
  }
