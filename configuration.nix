{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 5;
  boot.kernelParams = [ "console=ttyS0,115200n8" "nixos-install.no-modprobe" "nixos.shell=0" ];

  boot.supportedFilesystems = [ "ext4" "ntfs" "vfat" ];

  boot.extraModulePackages = [ pkgs.kernelModules.vboxguest pkgs.kernelModules.vboxsf ];

  users.extraUsers.alx = {
    isNormalUser = true;
    home = "/home/alx";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    hashedPassword = "$6$3V32/J2L$bK45o2HzkYXcjO0msbDldHoiJqCvDu2tXn9QGYaGJrZ4wRS0wgmBX/rZmLN1LQEPL0rJSTGIQpnmfnv10/LAw/";
  };

  # Enable OpenSSH server.
  services.openssh.enable = true;
  services.xserver.enable = true;

  # Enable desktop manager.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  # Install and configure Alacritty terminal.
  programs.alacritty = {
    enable = true;
    extraConfig = ''
      scrollback: 10000
    '';
  };

  # Install and configure ZSH with Oh-my-zsh.
  packages = [
    pkgs.zsh
    pkgs.ohMyZsh
  ];

  users.users.alx.shell = pkgs.zsh.bin;

  environment.shell = pkgs.zsh.bin;

  user.zsh = {
    theme = "agnoster";
    plugins = [
      "git"
      "zsh-syntax-highlighting"
    ];
  };

  # Install and configure syntax highlighting for Kate editor.
  programs.kate = {
    enable = true;
    extraPackages = [
      pkgs.katepart5.R
      pkgs.katepart5.haskell
      pkgs.katepart5.html
      pkgs.katepart5.javascript
      pkgs.katepart5.lisp
      pkgs.katepart5.python
    ];
  };

  # Install packages.
  environment.systemPackages = with pkgs; [
    solaar
    tlp
    git
    vlc
    pulseaudio
    pavucontrol
    chromium
    virtualbox
    freecad
    dolphin
    bleachbit
    qbittorrent
    synaptic
    prusa-slicer
    printrun
    octoprint
  ];

  # Add material design icons.
  fonts.fonts = with pkgs; [
    ttf-ubuntu-font-family
    ttf-dejavu
    ttf-liberation
    material-design-icons
  ];

  # Set Nordic themes.
  services.xserver = {
    desktopManager.gnome3.enable = false;
    desktopManager.kde4.enable = false;
    desktopManager.xfce.enable = false;
    desktopManager.mate.enable = false;
    windowManager.openbox.enable = true;
    displayManager.lightdm.enable = true;
    windowManager.openbox.theme = "nordic-darker";
    windowManager.openbox.themes = [ pkgs.nordic-theme-ob pkgs.nordic-theme-gtk pkgs.nordic-theme-icons ];
  };

  # Configure power management settings.
  services.tlp = {
    enable = true;
    mode = "battery";
    autosuspend.usbTypeAC = 1;
    autosuspend.usbTypeBattery = 1;
    disk.idleTimeoutSeconds = 1800;
    wifi.powersave = true;
  };

  # Add system information script.
  environment.systemPackages = with pkgs; [
    dmidecode
  ];

