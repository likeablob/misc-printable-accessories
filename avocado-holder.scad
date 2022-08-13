include <scad-utils/morphology.scad>

$fn = 80;

/* Variables */
// Cup diameter
CUP_D = 76;
// Cup edge width
CUP_EDGE_W = 2;

// Holder center hole diameter (seed diameter)
AVOCADO_HOLDER_HOLE_D = 36;
// Holder dimensions
AVOCADO_HOLDER = [ CUP_D + 6, AVOCADO_HOLDER_HOLE_D + 6, 3 ];

module avocado_holder() {
  difference() {
    // body
    linear_extrude(height = AVOCADO_HOLDER.z, center = !true, convexity = 10,
                   twist = 0) {
      rounding(r = 5) {
        intersection() {
          circle(d = AVOCADO_HOLDER.x);
          square(size = [ AVOCADO_HOLDER.x, AVOCADO_HOLDER.y ], center = true);
        }
      }
    }

    // center hole
    cylinder(h = AVOCADO_HOLDER.z + 0.1, d1 = AVOCADO_HOLDER_HOLE_D,
             d2 = AVOCADO_HOLDER.y - 1);

    // chase for the edge
    chase_w = CUP_EDGE_W + 1;
    linear_extrude(height = AVOCADO_HOLDER.z - 1, center = false,
                   convexity = 10, twist = 0) {
      shell(d = chase_w, center = true) circle(d = CUP_D - CUP_EDGE_W);
    }
  }
}

avocado_holder();