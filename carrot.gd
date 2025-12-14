extends CharacterBody2D

var TurnSpeed = 0.1
var BounceForce = 600
var Grav = 25

var LastRotation = 0

var control = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		$AnimationPlayer.play("RESET")
		velocity = Vector2(0, 0)
		rotation_degrees = 0
		position = Vector2(0, 0)
		control = true
	if control == true:
		turn()
	move()

func turn():
	rotate(TurnSpeed * Input.get_action_strength("Right") - TurnSpeed * Input.get_action_strength("Left"))

func move():
	if is_on_floor():
		if rotation_degrees > 85 or rotation_degrees < -85:
			if control == true:
				$Timer.start()
				$AnimationPlayer.play("Stunned")
				control = false
		else:
			LastRotation = rotation
		velocity -= Vector2(0, BounceForce).rotated(LastRotation)
	else:
		velocity.y += Grav
	move_and_slide()



func _on_timer_timeout() -> void:
	$AnimationPlayer.play("RESET")
	control = true
	rotation = 0
