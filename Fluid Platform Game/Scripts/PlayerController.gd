extends CharacterBody2D

@export var walk_speed := 200.0
@export var run_speed := 400.0
@export_range(0, 1) var acceleration := 1.0
@export_range(0, 1) var friction := 0.1
@onready var jump_sfx = $jump_sfx as AudioStreamPlayer

@export var jump_force := -500.0
@export_range(0, 1) var jump_height_desacelerate := 0.5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = walk_speed

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		animation.play("jump")
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_sfx.play()
		velocity.y = jump_force
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_height_desacelerate
	
	if Input.is_action_pressed("run") and is_on_floor():
		speed = run_speed
	elif Input.is_action_just_released("run"):
		speed = walk_speed
	
	var direction = Input.get_axis("left", "right")
	if direction:
		animation.scale.x = direction
		if is_on_floor():
			if speed == walk_speed:
				animation.play("walk")
			else:
				animation.play("run")
		accelerate(direction)
	else:
		if is_on_floor():
			animation.play("idle")
		add_friction()

	player_movement()
	

func accelerate(direction):
	velocity.x = move_toward(velocity.x, speed * direction, speed * acceleration)
	
func add_friction():
	velocity.x = move_toward(velocity.x, 0, speed * friction)

func player_movement():
	move_and_slide()

func play_animation():
	pass
