extends RigidBody

export var key_name = ""

signal key_collected(key_name)

func _on_Area_body_entered(body):
	emit_signal("key_collected",key_name)
	queue_free()
