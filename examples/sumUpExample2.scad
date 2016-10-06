include<sumup.scad>

sumUp()
{
	remove()
		translate([0,0,10])
			#cube([20,12,4],center=true);
	
	add() 
		translate([0,0,10])
			sphere(6);
	add()
		translate([7,4,4])
			cylinder(h=15,d=3,$fn=10);
}
remove()
		translate([0,0,10])
		#cube([20,12,4],center=true);

