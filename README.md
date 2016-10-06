# sumUp
*sumUp()* is a more powerful replacement for openscads *difference()* 

it allows you to add holes in modules and a more flexibe, but descriptive syntax by using _predicates_. it usually requires less nesting in your code. 
it is very compact: only 2 pages in a single include file you will need

Use *sumUp()* where you have used *difference()* before,
just add one of predicates like *add()*, *remove()* or *addAfterRemoving()* to each block inside of your difference()(which is now a *sumUp()* of course)
```c#
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
```
![screeen](/images/sumUpExample1.png)

unlike _difference()_ where  the first line or the first block inside the _difference()_'s curly brackets is THE THING you subtract from, 
inside the _sumUp()_ the first line or block can be any of add or remove predictes. that is - the first line or block inside its curly barckets has no special meaning in sumUp(). so you can constuct a solid from several lines/blocks/modues. you do not have to use _union()_ to put them all together into the first block/line of the _difference()_.
then you can remove from this "summed" solid in the same single _sumUp()_ (and even add again, but this i further down)
```c#
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
```

![screeen](/images/sumUpExample2.png)

_sumUp()_ uses the prediacte to recognize if the block is to be removed, removed from, or added after all removing is done. 

you can move the predicates inside your modules, and call the module without any predicate.
the module itself then uses predicates to add new things, even BORE HOLES IN OTHER SOLIDS of _SumUp()_, and say add bolts inside new holes to your part.

but YOU CAN use your old modules which do not use predicates:
either without touching them:
you add a predicate before you call your old module form withing sumUp() like this: 
```c#
sumUp()
{
	translate([0,20,0])
	  add() anyOldModule();
	remove() {  ....}
}
```
or you  add a predicate (say add() ) to modules declaration after the module name, and then call it without any additional predicates like this:
include<sumup.scad>
```c#
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

```
![screeen](/images/sumUpExample3.png)

you just put the predicates in front of the parts of your module to signalize what this concrete part is used for (see below)


example of all above possibilities and a bit more:
![screeen](/images/sumUpExample.png)
```c#

include<sumup.scad>

sumUp()
{
  translate([0,20,0])
    {
      anyOldModule();
      boreHolesNewModule();
    }
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
```

in fact you could leave the brackets out alltogether like this: sumUp() allIsDoneHere();
if the allIsDoneHere() module contains all predicates you are using.

