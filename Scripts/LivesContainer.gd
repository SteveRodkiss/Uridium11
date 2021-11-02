extends GridContainer

#just show the correct number of icons- thats it
func set_lives(num_lives):
	#hide all health icons
	$Icon1.hide()
	$Icon2.hide()
	$Icon3.hide()
	#enable the ones we need based on num_lives
	if num_lives > 0:
		$Icon1.show()
	if num_lives > 1:
		$Icon2.show()
	if num_lives > 2:
		$Icon3.show()
	
