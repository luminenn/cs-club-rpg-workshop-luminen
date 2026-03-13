extends CharacterBody2D


const PLAYER_MAX_SPEED: float = 70
		
@onready var sprite: CharacterSprite = $Sprite2D		


func _physics_process(_delta: float) -> void:
	# Don't simulate anything if we're in the editor
	if Engine.is_editor_hint():
		return
		
	animate()
	move()
	

func animate() -> void:
	# Do the direction
	if velocity.x > 0:
		sprite.dir = sprite.Dir.RIGHT
	elif velocity.x < 0:
		sprite.dir = sprite.Dir.LEFT
	elif velocity.y < 0:
		sprite.dir = sprite.Dir.UP
	elif velocity.y > 0:
		sprite.dir = sprite.Dir.DOWN
		
	# Do the walk and idle
	const frame_time: float = 0.1
	if velocity == Vector2.ZERO:
		sprite.anim_frame = 1
	else:
		# Generate a frame index based on elapsed time
		var index := Time.get_ticks_msec() / int(frame_time * 1000) % 4
		match (index):
			0:
				sprite.anim_frame = 0
			1:
				sprite.anim_frame = 1
			2:
				sprite.anim_frame = 2
			3:
				sprite.anim_frame = 1
	
	
func move() -> void:
	var input := Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input * PLAYER_MAX_SPEED
	move_and_slide()
	
