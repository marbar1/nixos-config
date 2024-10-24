flake-overlays:

{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./hardware-configuration.nix ./system/wm/gnome.nix ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixylap"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networkmanager

  # Set time zone
  time.timeZone = "Europe/Berlin";

  # Enable the X11 windowing system for xwayland.
  services.xserver.enable = true;

  # Configure keyboard settings
  services.xserver.xkb = {
    layout = "de";
    variant = "neo_qwertz";
  };

  virtualisation.docker = {
    enable = true;
  };

  # Enable the onedrive service
  services.onedrive.enable = true;

  nixpkgs.overlays = [
    (final: prev: {

    })
  ] ++ flake-overlays;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mbaer = {
    isNormalUser = true;
    # wheel -> Enable ‘sudo’ for the user.
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    home-manager
    libwacom
    matlab
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
