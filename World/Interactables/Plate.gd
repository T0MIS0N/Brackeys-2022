extends RigidBody

onready var _sound = $CollisionSound

signal emit_noise(location)

func _on_Area_body_entered(body):
	if !_sound.playing:
		_sound.play()
	#emit_signal("emit_noise",self.translation)
