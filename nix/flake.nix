{
	description = "<project name potukange>";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};
	outputs = {self, nixpkgs, flake-utils}:
	flake-utils.lib.eachDefaultSystem( sys:
	let
		pkgs = nixpkgs.legacyPackages.${sys};
	in {
		devShell.default = pkgs.mkShell {
			packages = with pkgs [ 

				# <packages potukange>

				# (haskellPackages.ghcWithPackages (hp: [
				# 	haskell packages potukange
				# ]))

			]
		}
	});
}
