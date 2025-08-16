{
  description = "NIX PODMAN";

  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
  	utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lnx-pkgs = nixpkgs.legacyPackages.aarch64-linux;

		ubuntuBase = pkgs.dockerTools.pullImage {
			imageName = "ubuntu";
			imageDigest = "sha256:1aa979d85661c488ce030ac292876cf6ed04535d3a237e49f61542d8e5de5ae0";
			sha256 = "sha256-5iXayI1eaOQlLElPczlRmCjr9OOmMCubhm43JjjU0Tc=";
			finalImageTag = "22.04";
		};

        nginx-container = pkgs.dockerTools.buildLayeredImage {
        	name = "nginx";
        	tag = "latest";
			fromImage = ubuntuBase;
          	contents = with lnx-pkgs; [ nginx ];
          	extraCommands = ''
            	mkdir -p var/log/nginx
			'';
          	config = {
          		Cmd = [ "nginx" "-g" "daemon off;" ];
          	};
        };
      in {
        devShells.default = pkgs.mkShell {
          	packages = with pkgs; [ podman gnumake ];
          	shellHook = ''
            	if ! podman machine inspect >/dev/null 2>&1; then
              	podman machine init
            	fi
            	podman machine start
          	'';
        };
        packages = {
        	nginx = nginx-container;
        };
      });
}
