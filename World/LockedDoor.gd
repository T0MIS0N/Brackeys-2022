extends StaticBody

export var door_name = ""
var key_name=""

func _on_Player_Character_transmit_keys(key_array):
	if key_array.has(door_name):
		key_name = door_name

func _on_Area_body_entered(body):
	if key_name == door_name:
		queue_free()
