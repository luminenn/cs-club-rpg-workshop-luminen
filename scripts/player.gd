extends CharacterBody2D


const PLAYER_MAX_SPEED: float = 70
		
var direction: Vector2 = Vector2.DOWN

@onready var sprite: CharacterSprite = $Sprite2D		

func _ready() -> void:
	$AttackHitbox.monitoring = false
	$AttackHitbox.hide()


func _physics_process(_delta: float) -> void:
	animate()
	move()
	# Update direction vector
	if velocity != Vector2.ZERO:
		direction = velocity
	
	# Handle attack
	if Input.is_action_just_pressed("attack"):
		$AttackHitbox.monitoring = true
		$AttackHitbox.show()
		$Slash.play()
		
		# rotate hitbox in direction of movement
		$AttackHitbox.rotation = direction.angle()
		
		# wait 1 second
		$AttackTimer.start(0.3)
		# turn off the hitbox (this is handled via a signal)
				
		
	# If player is not pressing space, hitbox should be off
	# If the player presses space, hitbox turn on for 
	# some time
		
		

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
	


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	# DAMAGE THE SLIME!!!
	if body.is_in_group("enemy"):
		body.damage()


func _on_attack_timer_timeout() -> void:
	$AttackHitbox.monitoring = false
	$AttackHitbox.hide()
