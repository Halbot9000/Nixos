Nixos Configuration
This is a README file for a NixOS configuration that includes the following:

LightDM display manager with Openbox window manager as default
Alacritty terminal emulator
ZSH shell with Oh-my-zsh, and Alacritty as default terminal emulator
Kate text editor with syntax highlighting for several programming languages
Additional packages including solaar, tlp, git, VLC, Pulseaudio, Chromium, VirtualBox, Freecad, Dolphin, Bleachbit, qBittorrent, and Synaptic
Material design icons and Nordic theme for X server
Power management with TLP package
System information and logging tools including lshw, lsblk, lspci, lsusb, dmidecode, uname, top, ps, ifconfig/ip, iwconfig, xrandr, lsmod, blkid, mount, df, du, free, and uptime

# LightDM and Openbox Configuration
services.lightdm.enable = true;
services.lightdm.displayManager.openbox.enable = true;

# Alacritty Configuration
programs.alacritty = {
  enable = true;
  extraConfig = ''
    # Set Alacritty as default terminal emulator
    default_prog = ["${pkgs.alacritty}/bin/alacritty"];
  '';
};

# ZSH with Oh-my-zsh Configuration
programs.zsh.enable = true;
programs.zsh.enableCompletion = true;
programs.zsh.promptInit = true;
programs.zsh.ohMyZsh.enable = true;
programs.zsh.ohMyZsh.theme = "agnoster";
programs.zsh.defaultShell = true;
programs.zsh.promptInit = ''
  # Set Alacritty as default terminal emulator
  if [[ "${TERM_PROGRAM}" == "alacritty" ]]; then
    chpwd() { print -P "\033]0;%n@%m:%~\007"; }
  fi
'';

# Kate Configuration
services.xserver.desktopManager.default = "openbox";
programs.kate.enable = true;
programs.kate.extraPlugins = with pkgs.kate; [
  kate-plugins.katebuild
  kate-plugins.katefilebrowser
  kate-plugins.kateproject
  kate-plugins.katesnippets
  kate-plugins.katepartsyntaxhighlighting
];

# Additional Packages
environment.systemPackages = with pkgs; [
  solaar tlp git vlc pulseaudio chromium virtualbox freecad dolphin bleachbit qbittorrent synaptic
];

# Material Design Icons and Nordic Theme Configuration
services.xserver = {
  enable = true;
  displayManager.lightdm.theme = "nordic";
  desktopManager.default = "openbox";
  windowManager.openbox = {
    enable = true;
    package = pkgs.openbox;
    extraConfig = ''
      # Add Material Design Icons
      [ "${pkgs.obmenu}/share/icons/material-design-icons" ]
      [ "${pkgs.obmenu}/share/icons/material-design-icons-dark" ]
      [ "${pkgs.obmenu}/share/icons/material-design-icons-light" ]
      theme="/usr/share/icons/material-design-icons"
    '';
  };
};

# TLP Configuration
services.tlp.enable = true;

# System Information and Logging Tools Configuration
environment.systemPackages = with pkgs; [
  lshw lsblk lspci lsusb dmidecode uname top ps ifconfig ip iwconfig xrandr lsmod blkid mount df du free uptime
];


This configuration provides a customized NixOS setup with a lightweight display manager and window manager, a fast and customizable terminal emulator with ZSH shell and Oh-my-zsh, and a versatile ext editor with syntax highlighting for multiple programming languages. It also includes several additional packages for productivity and entertainment, as well as a Material Design Icons set and a Nordic theme for the X server.

Power management is enabled through the TLP package, and the configuration also includes various system information and logging tools, such as lshw, lsblk, lspci, lsusb, dmidecode, uname, top, ps, ifconfig/ip, iwconfig, xrandr, lsmod, blkid, mount, df, du, free, and uptime.

To use this configuration, simply copy and paste the above code into your configuration.nix file, and then run nixos-rebuild switch to apply the changes.

Enjoy your new NixOS setup!
