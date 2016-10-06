include<sumup.scad>

sumUp()
{
	
	add() 
		translate([0,0,10])
			sphere(6);

	#translate([0,0,3])
		remove()
			cylinder(h=15,d=8,$fn=10);
}

