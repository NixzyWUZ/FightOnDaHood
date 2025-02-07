extends CharacterBody2D

var speed = 70 #determinar a velocidade dele
var player_chase = false # denifir se o inimigo está ou não atrás dele
var player = null #definindo que por enquanto o player é nada

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

 
func _physics_process(delta): # aiai vamo lá...
	#$AnimatedSprite2D.play("idle")
	
	if player_chase == false: #se a perseguisão for true então..
		$AnimatedSprite2D.play("idle")
		
	else:	
		position += (player.position - position)/speed
		# ^ vou definir que a posição dele vai ser baseada nesse calculo
		
		#ele vai andar qaundo eu entrar no campo de visao dele
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	
func _on_area_2d_body_entered(body): #func na qual vai dizer quando estiver na area do inimgo
	player = body #dizer que o player vai ser o body da func.
	player_chase = true #chase pode começar

func _on_detection_body_exited(body): #func na qual vai dizer quando não estiver na area do inimgo
	player = null
	player_chase = false
