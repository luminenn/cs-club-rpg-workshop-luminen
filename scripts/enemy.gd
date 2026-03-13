extends CharacterBody2D

var max_health: int = 5
var health: int = 5

func damage() -> void:
	#health = health - 1
	health -= 1
	$Hit.play()
	print(health)
	if health <= 0:
		$Dead.play()
		$Sprite2D.hide()
		$DeadSprite.show()
