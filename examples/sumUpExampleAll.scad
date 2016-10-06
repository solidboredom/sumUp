include<sumup.scad>

sumUp()
{
	
	translate([0,20,0])
	{
		newCubeBlockModule(); 
		translate([8,18,0])
			 nailWithBiggerBore($fn=20);
	}	
	
	translate([0,15,5])
		lid();
	
	add() 
		anyOldModule();
	add() 
		translate([0,0,10])
			sphere(6);
	boreHolesNewModule();

	translate([7,5,0])
		remove()
			cylinder(h=15,d=3,$fn=10);
}


//having the add() predicate makes the module to produce solids
module newCubeBlockModule() add()
{
	translate([-2,-2,0])cube([27,27,10]);
}
//having the remove predicate makes the module produce Only Holes
module boreHolesNewModule(d=3.5,depth=17) remove() 
{
cylinder(d=d,h=depth);
translate([0,0,10])rotate([0,90,90])cylinder(d=d,h=depth,center=true);
}

//uses add(), remove() and addAfterRemoving() predicates to 
// remove material and boring holes (in all solids including those produced by other
// modules called within SumUp())
//and add a "Lid" and four "Bolts"  
module lid($fn=50)
{
	remove() translate([-1,-1,-2]) cube([20+2,20+2,8]);
	addAfterRemoving() cube([20,20,3]);
	for(x=[3,17],y=[3,17])translate([x,y,-6])
	 	{
	 		remove() cylinder(h=25,d=3.5);
			addAfterRemoving() cylinder(h=10,d2=3,d1=1);
		}
}

 //OR AN ADVACED VERSION HERE more succint 
 //with diameter modifyers and predicate variables instead of predicates
module nailWithBiggerBore()
if(!$beforeRemoving)
	translate([0,0,-($removing?1:0)])
		cylinder(d1=1+($removing?1:0),d2=3+($removing?2:0),h=11+($removing?1:0));

// USE any existing module in summUp too just add a predicate when calling it
module anyOldModule()
{
cube([10,10,10]);
cylinder(h=15,d=10);
}
