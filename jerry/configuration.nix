{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ];

  networking.hostName = "jerry";

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  age.secrets.openweather.file = ../secrets/openweather.age;

  serenity = {
    localDev = {
      enable = true;
      enableVSCodeServer = true;
    };
    services.weatherframe = {
      enable = true;
      weatherLat = 33.617;
      weatherLon = -117.831;
      apiKeyPath = config.age.secrets.openweather.path;
    };
  };

  environment.systemPackages = [
    pkgs.openwx
    pkgs.tatted # binary is called tatctl
  ];
}
