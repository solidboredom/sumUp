
//Copyright and related rights waived by the author via CC0
include<sumup.scad>

sumUp()
{
  add()
    cube([20,20,7],center=true);
  lidWithNailsAndWasher();
}

//== modules below  ==
module lidWithNailsAndWasher()
{
  add() //washer
	translate([0,0,8])
  	   cube([20,20,1],center=true);
  addAfterRemoving() //top cover without holes
     translate([0,0,11])
	   color("green")
         cube([17,17,2],center=true);
for(x=[-1,1],y=[-1,1])
  translate([x*7,y*7,2])
  {
    remove() 
	  cylinder(h=25,d=4.5,center=true);
   #addAfterRemoving() 
      cylinder(h=10,d2=3,d1=1);
  }
}


