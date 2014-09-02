//created by bloomlj 2014.09.20

module heng(){
	union() {
        	cylinder(h = 70, r1 = 25, r2 = 25, center = true);
		  translate([0,0,35]) 
        	cube(size = 10, center = false);
		  translate([0,0,-45]) 
        	cube(size = 10, center = false);
	}
}

heng();

