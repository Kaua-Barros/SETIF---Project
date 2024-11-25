extends ParallaxLayer

@export var cloud_speed: float = -15.0

func _process(delta: float) -> void:
	motion_offset += Vector2(cloud_speed * delta, 0)
