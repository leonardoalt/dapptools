{ pkgs }:

let
  ds-test-src = pkgs.fetchFromGitHub {
    owner = "dapphub";
    repo = "ds-test";
    rev = "eb7148d43c1ca6f9890361e2e2378364af2430ba";
    sha256 = "1phnqjkbcqg18mh62c8jq0v8fcwxs8yc4sa6dca4y8pq2k35938k";
  } + "/src";

  ds-test = pkgs.buildDappPackage {
    src = ds-test-src;
    name = "ds-test";
    doCheck = false;
  };

  chai-src = pkgs.fetchFromGitHub {
    owner = "dapphub";
    repo = "chai";
    rev = "b75edb6409d51fd91e53e73f77092b573c4242a9";
    sha256 = "0b39wshc901pbrv0dvm8fll4dapfn5gjwliv0w6q8f3ahhi8j2cc";
  } + "/src";

  chai = pkgs.buildDappPackage {
    src = chai-src;
    name = "chai";
    doCheck = false;
  };

in
  pkgs.buildDappPackage {
    name = "dapp-tests";
    src = ./.;
    deps = [ ds-test chai ];

    checkInputs = with pkgs; [ hevm jq seth dapp solc ];
  }
