extends StaticBody

func _on_Area_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
