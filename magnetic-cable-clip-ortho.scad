include <scad-utils/mirror.scad>
include <scad-utils/morphology.scad>

$fn=50;

MG_Z=2.7;
SCREW_Z=3;

CABLE_X=5.5;
CABLE_Z=4.8;

BODY_X=25;
BODY_Y=25;
BODY_TOP_Y=20.5;
BODY_BOTTOM_Z=2;
BODY_TOP_Z=3;
BODY_Z=BODY_TOP_Z + BODY_BOTTOM_Z + MG_Z + CABLE_Z;

difference(){
  // body
  linear_extrude(height=BODY_Z, center=!true, convexity=10, twist=0)
  rounding(r=2)
  square(size=[BODY_X, BODY_Y], center=true);

  // magnet space & screw hole
  translate([0, 0, BODY_Z - SCREW_Z - MG_Z - BODY_TOP_Z]) {
    cylinder(d=1.5, h=MG_Z+SCREW_Z, center=!true);
    translate([0, 0, SCREW_Z])
    cylinder(d=10.8, h=MG_Z + 0.5, center=!true);
  }

  // top space
  translate([0, 0, 10/2 + BODY_Z - BODY_TOP_Z]) 
  cube(size=[BODY_TOP_Y, BODY_Y+1, 10], center=true);

  // cable space
  rotate([0, 0, 90]) 
  translate([CABLE_X/2 + 2, 0, BODY_Z/2 + BODY_BOTTOM_Z]) 
  cube(size=[CABLE_X, BODY_Y*2, BODY_Z], center=true);
}

// cable
rotate([0, 0, 90]) 
%translate([CABLE_X/2+2, 0, CABLE_Z/2 + 2]) 
cube(size=[CABLE_X, BODY_Y*2, CABLE_Z], center=true);
