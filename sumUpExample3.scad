include<sumup.scad>

sumUp()
{

	newCubeBlockModule();
	add() 
		translate([0,0,10])
			sphere(6);
	boreHolesNewModule();
}

module newCubeBlockModule() add()
{
	translate([-2,-2,0])cube([10,10,10]);
}

module boreHolesNewModule(d=3.5,depth=17) remove() 
{
cylinder(d=d,h=depth);
#translate([0,0,10])
	rotate([0,90,90])
		cylinder(d=d,h=depth,center=true);
}

