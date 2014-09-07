
// By Chillance < chillance@gmail.com >
//20140907 modified by bloomlj <bloomlj@qq.com>


use_middle_belt = 0;
use_side_belt = 0;


main_cube_width = 42; //1515 => 39,2020=>42
main_cube_length = 40;
main_height = 8;
height_offset = 0;
rod_fastener_height = 10 + main_height;
rod_fastener_width = 14;
rod_fastener_length = 8;

round_r = 3;
pad = 0.1;
smooth = 50;

rod_offset = 3;


belt_width = 18; // 7
belt_x = 5.6;
belt_z = 7;


cutter_bag = 2;
minimal_cut = (main_cube_width/4)*0.3;
rest_cut = (main_cube_width/4)*0.7;

extra_belt_support_length = 25;
extra_belt_support_height = 17;


module oval(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, $fn=150, center=center);
}

module extra_belt_support(width)
{
  translate([0, 0, belt_width/8]) {
    difference() {
      cube([width, extra_belt_support_length, extra_belt_support_height], center = true);

      translate([-5, -extra_belt_support_length/2, -extra_belt_support_height/4]) {
        rotate([90, 0, 0]) {
          oval(5, 5, 10, $fn=100, center = true);
        }
      }

      translate([-5, extra_belt_support_length/2, -extra_belt_support_height/4]) {
        rotate([90, 0, 0]) {
          oval(5, 5, 10, $fn=100, center = true);
        }
      }


      translate([0, -extra_belt_support_length/2, extra_belt_support_height/2]) {
        rotate([0, 90, 0]) {
          cylinder(r=6/2, h=main_height+height_offset, $fn=150, center = true);
        }
      }

      translate([0, extra_belt_support_length/2, extra_belt_support_height/2]) {
        rotate([0, 90, 0]) {
          cylinder(r=6/2, h=main_height+height_offset, $fn=150, center = true);
        }
      }

      translate([0, extra_belt_support_length/2, -extra_belt_support_height/2]) {
        rotate([0, 90, 0]) {
          oval(extra_belt_support_height/3, 5, 10, $fn=100, center = true);
        }
      }

      translate([0, -extra_belt_support_length/2, -extra_belt_support_height/2]) {
        rotate([0, 90, 0]) {
          oval(extra_belt_support_height / 3, 5, 10, $fn=100, center = true);
        }
      }
    }
  }
}

module main_part()
{
  cube([main_cube_width, main_cube_width, main_height+height_offset], center = true);
  translate([0, main_cube_width/2, 0]) {
    cylinder(r=main_cube_width/2, h=main_height+height_offset, $fn=150, center = true);
  }

  // Belt clamps.
  if (use_middle_belt < 1) {

    translate([-2, -10, main_height/2]) {

      translate([-3, 0, belt_width/2])
        difference() {
          union() {
            cube([3, 15, belt_width+4], center=true);

            extra_belt_support(3);

          }


          translate([0, 0, (belt_width+4)/2-3]) {
            rotate([0, 90, 0]) {
              cylinder(r=3.3/2, h=main_height+height_offset, $fn=150, center = true);
            }
          }

          translate([-3/2, -100/2, 0]) {
            // GT2 belt
            for ( i = [0 : 2 : 100] )
            {
              translate([0, i, 0])
                cube([3, 1.5, belt_width+4], center = true);
            }
          }

          translate([-3/2, 0, belt_width/2]) {
            cube([3, 6, 6], center = true);
          }
        }


      translate([-8.5, 0, belt_width/2]) {
        difference() {
          union() {
            cube([4, 15, belt_width+4], center=true);

            extra_belt_support(4);
          }

          translate([0, 0, (belt_width+4)/2-3]) {
            rotate([0, 90, 0]) {
              cylinder(r=3.3/2, h=main_height+height_offset, $fn=150, center = true);
            }
          }
        }
      }


    }
  }


}

module cutter()
{
  translate([main_cube_width/4+minimal_cut/2, cutter_bag/2, 0]) {
    cube([minimal_cut+cutter_bag, cutter_bag, main_height + height_offset + 2], center = true);
  }
  translate([main_cube_width/4+minimal_cut, -main_cube_length/8, height_offset/2]) {
    cube([cutter_bag, main_cube_length/4+cutter_bag, main_height + (height_offset*2) + 2], center = true);
    rotate([0, 90, 0]) {
		//the 1.5 hole is for to change the tanli
      cylinder(r=1.5, h=100, $fn=100, center = true);
    }
  }
  translate([main_cube_width/4+rest_cut, -main_cube_length/4, 0]) {
    cube([rest_cut, cutter_bag, main_height + height_offset + 2], center = true);
  }
}

module rod_rounding()
{
  translate([0, -rod_fastener_length/2+round_r, rod_fastener_height/2-round_r+(height_offset/2)]) {
    difference() {
      translate([0,-round_r+pad,round_r+pad])
        cube([rod_fastener_width+2*pad, round_r*2+pad, round_r*2+pad], center = true);
      rotate(a=[0,90,0]) {
        cylinder(rod_fastener_width+4*pad,round_r,round_r,center=true,$fn=smooth);
      }
    }
  }
}

module rod_holder()
{
  translate([(main_cube_width/2) - (rod_fastener_width/2) + rod_offset, -main_cube_length/2, rod_fastener_height/2 - main_height/2]) {
    difference() {
      union() {
        cube([rod_fastener_width, rod_fastener_length, rod_fastener_height+height_offset], center = true);
        translate([rod_fastener_width/2-rod_offset, rod_fastener_length/2-rod_offset/2, -rod_fastener_height/2+main_height/2]) {
          cylinder(main_height + height_offset, rod_offset, rod_offset, center=true, $fn=smooth);
        }
      }

      translate([0, -rod_fastener_length/2, -rod_fastener_height/2]) {
        rotate([23, 0, 0]) {
          cube([rod_fastener_width+0.2, 7.5, 100], center = true);
        }
      }

      translate([rod_fastener_width/2, 0, rod_fastener_height/2]) {

        translate([0, 0, -(rod_fastener_height-main_height)/2]) {
          difference() {
            translate([0, 0, 4]) {
              rotate([0, 0, 0]) {
                cube([rod_fastener_width-0.2, rod_fastener_length*2 + 0.2, rod_fastener_height/2 + 0.2], center = true);
              }

              rotate([25, 0, 0]) {
                cube([rod_fastener_width-0.2, rod_fastener_length*2 + 0.2, rod_fastener_height/2 + 0.2], center = true);
              }

              rotate([-25, 0, 0]) {
                cube([rod_fastener_width-0.2, rod_fastener_length*2 + 0.2, rod_fastener_height/2 + 0.2], center = true);
              }
            }


            rotate([0, -90, 0]) {
              cylinder(h = rod_fastener_width/1, r1 = 2.5, r2 = 8, center = false, $fn=100);
            }
          }
        }
      }


      translate([0, 0, (rod_fastener_height/3-2)+(height_offset)]) {
        rotate([0, 90, 0]) {
			 //r=1.5 is for the qiutou mount hole 
          cylinder(r=1.5, h=100, $fn=100, center = true);
        }
      }
      rod_rounding();
      mirror([ 0, 1, 0 ]) {
        rod_rounding();
      }
    }
  }
}


module main_carriage()
{
  translate([0, 0 , (main_height + height_offset)/2]) {
    difference() {
      main_part();
      translate([0, 0, (-main_height/2)]) {
        //cube([17, 100, height_offset+0.2], center = true);
      }
      if (height_offset > 0 ) {
        translate([0, 0, (-main_height/2)-height_offset-2]) {
          rotate([90, 0, 0]) {
            //cylinder(r=main_cube_width/4, h=100, $fn=150, center = true);
            //oval(main_cube_width/4, main_cube_width/6, 100, true);
            oval(17.8/2, main_cube_width/4.0, 100, true);
          }
        }
      }
      translate([0, main_cube_length/4, 0]) {
        cube([main_cube_width/2, main_cube_length/2, main_height + height_offset + 2], center = true);
      }
      translate([0, main_cube_length/2, 0]) {
        cylinder(r=main_cube_width/4, h=main_height + height_offset + 2, $fn=100, center = true);
        oval(main_cube_width/4, main_cube_length/3, main_height + height_offset + 2, $fn=100, center = true);
      }
      translate([-main_cube_width/2+(main_cube_width/8), -main_cube_length/4, 0]) {
			//roller mount hole 1#,to fix.from r=1.5 to 2.5 to fit m5
        cylinder(r=2.5, h=100, $fn=100, center = true);
        translate([0, 0, (main_height/2) + (60/2) + 0.01]) {
          //cylinder(r=6/2, h=60, $fn=100, center = true);
        }
        if (height_offset > 0 ) {
          translate([0, 0, -main_height/2-height_offset+bearing_inset]) {
            difference() {
              cylinder(r=12/2, h=bearing_inset+0.2, $fn=150, center = true);
              cylinder(r=5/2, h=bearing_inset+0.2, $fn=150, center = true);
            }
          }
        }
      }


      if (use_side_belt > 0) {
        translate([-main_cube_width/2+(main_cube_width/8), main_cube_length/8, height_offset/2]) {
          translate([0, 3, 0]) {
            rotate([0, 0, 0]) {
              
              cylinder(r=1.5, h=20, $fn=100, center = true);
            }
          }
          translate([0, -3, 0]) {
            rotate([0, 0, 0]) {
					
              cylinder(r=1.5, h=20, $fn=100, center = true);
            }
          }
        }
      }

      translate([-main_cube_width/2+(main_cube_width/8), main_cube_length/2, 0]) {
//roller mount hole 2#,to fix.from r=1.5 to 2.5 to fit m5
        cylinder(r=2.5, h=100, $fn=100, center = true);
        if (height_offset > 0 ) {
          translate([0, 0, -main_height/2-height_offset+bearing_inset]) {
            difference() {
              cylinder(r=12/2, h=bearing_inset+0.2, $fn=150, center = true);
              cylinder(r=5/2, h=bearing_inset+0.2, $fn=150, center = true);
            }
          }
        }
      }
      translate([main_cube_width/2-(main_cube_width/8), (main_cube_length/3)/2, 0]) {
//roller mount hole 3#,to fix.from r=1.5 to 2.5 to fit m5
        cylinder(r=2.5, h=100, $fn=100, center = true);
        if (height_offset > 0 ) {
          translate([0, 0, -main_height/2-height_offset+bearing_inset]) {
            difference() {
              cylinder(r=12/2, h=bearing_inset+0.2, $fn=150, center = true);
              cylinder(r=5/2, h=bearing_inset+0.2, $fn=150, center = true);
            }
          }
        }
      }


      cutter();

      if (use_middle_belt > 0) {

        // Cut for belt.
        translate([0, 0, (main_height+height_offset)/2]) {
          cube([13, 100, 1], center = true);
        }

        translate([9, -main_cube_length/4, 0]) {
          cylinder(r=1.5, h=main_height+height_offset+0.2, $fn=100, center = true);
        }
        translate([-9, -main_cube_length/4, 0]) {
          cylinder(r=1.5, h=main_height+height_offset+0.2, $fn=100, center = true);
        }
      }
    }

    rod_holder();
    mirror([ 1, 0, 0 ]) {
      rod_holder();
    }
  }
}


module belt_holder()
{
  difference() {
    union() {
      cube([10, 12, 15], center = true);
      translate([0, 0, -15/2]) {
        difference() {
          union() {
            cube([10, 40, 3], center = true);
            cube([18, 10, 3], center = true);
            translate([-18/2, 0, 0]) {
              cylinder(3, r=10/2, r=10/2, center=true, $fn=150);
            }
            translate([18/2, 0, 0]) {
              cylinder(3, r=10/2, r=10/2, center=true, $fn=150);
            }
          }
          translate([18/2, 0, 0]) {
            cylinder(100, r=3/2, r=3/2, center=true, $fn=150);
          }
          translate([-18/2, 0, 0]) {
            cylinder(100, r=3/2, r=3/2, center=true, $fn=150);
          }
        }
      }
    }
    translate([0, 3, 3]) {
      rotate([0, 90, 0]) {
        cylinder(100, r=3/2, r=3/2, center=true, $fn=150);
      }
    }
    translate([0, -3, 3]) {
      rotate([0, 90, 0]) {
        cylinder(100, r=3/2, r=3/2, center=true, $fn=150);
      }
    }
  }
}


main_carriage();
translate([-main_cube_width, 0, 9]) {
  //belt_holder();
}


