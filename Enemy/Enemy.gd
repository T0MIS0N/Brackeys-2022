extends Spatial

signal candle_change(candle_range)

func _on_FlickerArea_body_entered(body):
	emit_signal("candle_change",5.5)

func _on_FlickerArea_body_exited(body):
	emit_signal("candle_change",7.5)

func _on_DeathArea_body_entered(body):
	get_tree().change_scene("res://Failure.tscn")

func _on_HearingArea_body_entered(body):
	emit_signal("candle_change",3.5)
	var tween:= create_tween()
	tween.tween_property(self,"translation",body.translation,2.5)
	#print(body.translation)

func _on_HearingArea_body_exited(body):
	emit_signal("candle_change",5.5)

func move_to_location(location):
	var tween:= create_tween()
	tween.tween_property(self,"translation",location,10)
	
func teleport_to_location(location):
	self.translation = location

func _on_LockedDoor2_move_monster():
	self.translation = Vector3(144,6,192)

func _on_LockedDoor1_move_monster():
	self.translation = Vector3(-54,6,456)

func _on_Player_Character_emit_noise(location):
	move_to_location(location)
