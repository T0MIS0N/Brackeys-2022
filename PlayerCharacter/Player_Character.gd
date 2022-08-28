extends KinematicBody

export var speed := 7.0
export var gravity := 50.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN
var _key_array: Array = []

onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $Armature
onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _candle: OmniLight = $Armature/Skeleton/Candle/OmniLight

signal transmit_keys(key_array)
signal emit_noise(location)

func _physics_process(delta):
	var move_direction = Vector3.ZERO
	move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#This may be the camera direction code and may need to be removed for a static camera.
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	#This normalization is the same as above, but with rotation scrapped as that uses rotation adn the camera here is static
	#move_direction = move_direction.normalized()
	
	_velocity.x = -move_direction.x * speed
	_velocity.z = -move_direction.z * speed
	_velocity.y -= gravity * delta
	
	#var just_landed = is_on_floor() and _snap_vector == Vector3.ZERO
	
	_snap_vector=Vector3.DOWN
	
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	if _velocity.x == 0 and _velocity.z == 0:
		_animation_player.play("Idle")
	else:
		_animation_player.play("Running")
		$Armature.look_at(move_direction + translation, Vector3.UP)
		$Armature.rotation_degrees.x = 0
		$Armature.rotation_degrees.z = 0
	
#func _process(delta):
#	_spring_arm.translation = translation

func _on_Key_key_collected(key_name):
	_key_array.push_back(key_name)
	print(_key_array)

func _on_DoorHitbox_body_entered(body):
	emit_signal("transmit_keys",_key_array)

func change_light_range(candle_range):
	_candle.omni_range = candle_range

func _on_Enemy_candle_change(candle_range):
	change_light_range(candle_range)

func _on_ObjectCollisionBox_body_entered(body):
	print("Noise made")
	emit_signal("emit_noise",body.translation)
	
func play_step_sound():
	if(!$FootStep.playing):
		$FootStep.play()
