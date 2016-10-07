//Copyright and related rights waived by the author via CC0

$summingUp=false;
$beforeRemoving=false;
$removing=false;

module sumUp(showRemovedOnly=false)
{
	$summingUp=true;
	if(!showRemovedOnly)
	{
		difference()
		{
			union()
			{
				$beforeRemoving=true;
				$removing=false;
				children([0:$children-1]);
			}
		
			union()
			{
				$beforeRemoving=false;
				$removing = true;
				children([0:$children-1]);
			}
		}			
		union()
		{
			$beforeRemoving=false;
			$removing = false;
			children([0:$children-1]);
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
module add()
{
	if(!$removing && $beforeRemoving) 
		children([0:$children-1]);
}
module remove()
{
	if($removing && !$beforeRemoving )children([0:$children-1]);
}
module addAfterRemoving()
{
	if(!$beforeRemoving && !$removing)children([0:$children-1]);
}
