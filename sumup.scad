
function contains(where,what) =  (len([for(el=toStrV(where))if(str(what)==el)1])!=0)?true:false;


//Copyright and related rights waived by the author via CC0
//21.10.2016: added isAddingAgain() shortcut
//22.07.2017 created isoateSums() and bugfixes to makeHollow
//20.08.2017 added PartOfAddAfterRemoving Variable
//23.08.2017 added $inverted Variable add invert()
$summingUp=false;
$beforeRemoving=false;
$removing=false;
$removingAgain=false;
$addingAgain=false;
$partOfAddAfterRemoving=false;
$inverted=false;



function isAddingFirst()=($summingUp && !$removing  && $beforeRemoving);
//function isAddingAgain()=($summingUp && !($beforeRemoving || $removing));

module assemble(steplist)
{
 for(step = steplist)
 {
 	$currentStep=step;
 	children();
 }
 //$currentStep=undef;
 //	children();
}
module only(step)
{
	if($currentStep== undef || contains($currentStep,step))
		children();

}

module invert(off=false)
{
$inverted=off?false:true;
children();
}

module isolateSums()
{
$summingUp=false;
$beforeRemoving=false;
$removing=false;
$removingAgain=false;
$addingAgain=false;
$partOfAddAfterRemoving=false;
$inverting=false;
children();
}

module makeHollow()
{
//if($removing)children();
//else
	difference()
	{
	children();
	union()
	{
	 $removing=true;
	 children();		
	
	}
	}
} 


module sumUp(showRemovedOnly=false)
{
	$addingLimiter=false;
	$beforeRemoving=false;		
	$removingAgain=false;
	$removing=false;
	$summingUp=true;
	if(!showRemovedOnly)
	{
		difference()
		{
			union()
			{
			
			intersection()
			{
			union()
			{
				$limiting=false;
				$beforeRemoving=true;
				$removing=false;
				children([0:$children-1]);
			}
			union()
			{
				$limiting=true;
				$addingLimiter=false;
				$beforeRemoving=false;
				$removing=false;
				children([0:$children-1]);
			}
			}
				union()
			{
				$limiting=false;
				$addingLimiter=true;
				$beforeRemoving=false;	;
				$removing=false;
				children([0:$children-1]);
			}
			}
		
			union()
			{
				$beforeRemoving=false;
				$removing = true;
				children([0:$children-1]);
			}
		}
		difference()
		{	
		$beforeRemoving=false;		
		$removingAgain=false;
		$removing=false;
		$addingAgain=true;
		union()
		{
		
			children([0:$children-1]);
		}
			union()
		{

			$removingAgain = true;
			children([0:$children-1]);
		}
		
	}
	}
	if(showRemovedOnly) 
	{
		$beforeRemoving=false;
		$summingUp=true;
		$removing = true;
	children([1:$children-1]);
	}
}

module addTo(body)
{
	only(body)add()children();
}
module removeFrom(body)
{
	only(body)remove()children();
}

module add()
{
	partOfAddAfterRemoving=false;
	if(!$removing && $beforeRemoving) 
		children([0:$children-1]);
}

module limiter()
{
	partOfAddAfterRemoving=false;
if(($limiting && !$removing )|| $addingLimiter) 
	{
			$beforeRemoving = true;
			children([0:$children-1]);
	}
}

module remove()
{
	partOfAddAfterRemoving=false;
	if($removing && !$beforeRemoving &&!$removingAgain )children([0:$children-1]);
}


module addAfterRemoving()
{
	$partOfAddAfterRemoving=true;
	if(!$beforeRemoving && !$removing && !$removingAgain)children([0:$children-1]);
}
module removeAgain()
{
	partOfAddAfterRemoving=true;
	if(!$beforeRemoving && !$removing && $removingAgain)children([0:$children-1]);
}

