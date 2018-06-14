
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
module only(body)
{
	if( $currentStep == undef 
		|| body == undef 
		|| contains($currentStep,body)
		)
		children();

}
module addTo(body)
{
	if( $currentStep == undef 
		|| body == undef 
		|| contains($currentStep,body)
		)
		add()children();
}
module limitTo(body)
{
	if( $currentStep == undef 
		|| body == undef 
		|| contains($currentStep,body)
		)
		limit()children();
}
module removeFrom(body)
{
	if( $currentStep == undef 
		|| body == undef 
		|| contains($currentStep,body)
		)
		remove()children();
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

module add(body)
{
	partOfAddAfterRemoving=false;
	if(
		(!$removing && $beforeRemoving)) 
			children([0:$children-1]);
}

module limiter(body)
{
	partOfAddAfterRemoving=false;
if(
		(($limiting && !$removing )|| $addingLimiter)) 
	{
			$beforeRemoving = true;
			children([0:$children-1]);
	}
}

module remove(body)
{
	partOfAddAfterRemoving=false;
	if(
		($removing && !$beforeRemoving &&!$removingAgain ))
			children([0:$children-1]);
}


module addAfterRemoving(body)
{
	$partOfAddAfterRemoving=true;
	if(		
		(!$beforeRemoving && !$removing && !$removingAgain))
			children([0:$children-1]);
}
module removeAgain()
{
	partOfAddAfterRemoving=true;
	if(
		(!$beforeRemoving && !$removing && $removingAgain))
			children([0:$children-1]);
}

