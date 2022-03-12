{
  description = ''A simple GUI front for Nimble.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimblegui-v0_2_1.flake = false;
  inputs.src-nimblegui-v0_2_1.owner = "ThomasTJdev";
  inputs.src-nimblegui-v0_2_1.ref   = "refs/tags/v0.2.1";
  inputs.src-nimblegui-v0_2_1.repo  = "nim_nimble_gui";
  inputs.src-nimblegui-v0_2_1.type  = "github";
  
  inputs."webgui".owner = "nim-nix-pkgs";
  inputs."webgui".ref   = "master";
  inputs."webgui".repo  = "webgui";
  inputs."webgui".type  = "github";
  inputs."webgui".inputs.nixpkgs.follows = "nixpkgs";
  inputs."webgui".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimblegui-v0_2_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimblegui-v0_2_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}