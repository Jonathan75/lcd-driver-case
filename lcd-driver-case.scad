t = .75;
// post back 108.47
// post front 115
// post depth 80
// post d 3

module frame(w,d,b){
  //b = boarder
  h = 1;
  b2 = b/2;
  difference(){
    cube([d+b2,w,h]);
    translate([b2,b2,-1]) cube([d-b2,w-b,h+2]);
  }
}
board_mount_depth = 27+2;
module board_mount(d){
  post_d = 3;
  post_d2 = post_d/2;
  w = 115+2-1;
  h = 1;
  /*d = 27+2;*/
  module front_board_mount(){
    d = post_d;
    d2 = d * .5;
    /*b = 10; //boarder
    b2 = b * .5;*/
    cube([d,w,h]);
    /*difference(){
    translate([b2,b2,0]) cube([d-b,w-b,h+1]);
    }*/
    translate([d2,post_d/2,h]) cylinder(d=post_d,h=5);
    translate([d2,w - post_d2,h]) cylinder(d=post_d,h=5);
  }

  module back_board_mount(){
    w = 108.47+1;
    d = post_d;
    d2 = d * .5;
    cube([d,w,h]);
    translate([d2,post_d/2,h]) cylinder(d=post_d,h=5);
    translate([d2,w - post_d2,h]) cylinder(d=post_d,h=5);
  }

  translate([d,0,0]) front_board_mount();
  //back_board_mount(); turn back on
  /*frame(w,d,1);*/
}


module hdmi(wall_depth){
  module pen() cylinder(d=1,h=wall_depth+2);

  translate([0,15.5,10]) rotate([90,180,90]) hull(){
    translate([0,2,0]) pen();
    translate([15,2,0]) pen();
    translate([15,5,0]) pen();
    translate([15-3,5+3,0]) pen();
    translate([3,5+3,0]) pen();
    translate([0,5,0]) pen();
  }
}

module ports(wall_depth){
  translate([-1,0,0]){
    translate([0,3-2,1]) cube([3+2,8.9+2,11]);//power jack
    translate([0,20,0]) hdmi(wall_depth);
  }
}
board_width = 139;
// board mount pin to plug edge 19.28
module front_wall(wall){
  w = board_width+2+2;
  translate([board_mount_depth+3,-11.82,0]){
    frame(w,19.28+3,2);
    translate([19+3.5,0,0]) {
    difference(){
          cube([1,w/3.5,16]);//wall
          ports(wall);
       }
    }
  }
}
wall_depth = 1;
front_wall(wall_depth);
board_mount(board_mount_depth);
