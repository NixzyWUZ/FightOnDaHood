extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

# Constantes para controlar a velocidade de movimento e a velocidade do pulo
const SPEED = 250.0  # A velocidade de movimento horizontal do personagem
const JUMP_VELOCITY = -480.0  # A velocidade do pulo (para cima, então é um valor negativo)
const MAX_Y = 550
const MIN_Y = 480

func _physics_process(delta: float) -> void:
	
	
	
	# Movimentação horizontal
	var direction_horizontal := Input.get_axis("ui_left", "ui_right")
	if direction_horizontal:
		# Direção positiva (movimento para a direita)
		if direction_horizontal > 0:
			velocity.x = direction_horizontal * SPEED
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("run")
		# Direção negativa (movimento para a esquerda)
		else:
			velocity.x = direction_horizontal * SPEED
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("run")
	else:
		# Se não há movimento horizontal, o personagem vai desacelerando até parar
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("default")
			
	var direction_vertical := Input.get_axis("ui_up", "ui_down")
	if direction_vertical != 0:
		velocity.y = direction_vertical * SPEED
		if direction_vertical < 0:
			pass
			#$AnimatedSprite2D.play("run")  # Andando para cima
		else:
			pass
			#$AnimatedSprite2D.play("run")  # Andando para baixo
		#moving = true  # Marcamos que há movimento vertical
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
			
			#limitar a area de movimentação
	position.y = clamp(position.y + velocity.y * delta, MIN_Y, MAX_Y)
	# Aplica a física do movimento (gravidade, colisões, etc.)
	move_and_slide()




func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "inimigo":
		print("took damage")
