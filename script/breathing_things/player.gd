class_name Player extends CharacterBody2D

var speed = 128
var vel = 128
var current_dir = "front"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_key_pressed(KEY_SHIFT):
		speed = vel * 1.5
	else: speed = vel


	if Input.is_action_pressed("Right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("Left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("Down"):
		current_dir = "front"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("Top"):
		current_dir = "back"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var animation_direction = "front"
	var animation_motion = "_idle"
	var flipped = false
	var anim = $AnimatedSprite2D

	match dir:
		"right":
			flipped = true
			animation_direction = "side"
		"left":
			flipped = false
			animation_direction = "side"
		"front":
			flipped = true
			animation_direction = "front"
		"back":
			flipped = true
			animation_direction = "back"
	if movement == 1:
		animation_motion = "_walk"
	
	anim.play(animation_direction + animation_motion)
	anim.flip_h = flipped
