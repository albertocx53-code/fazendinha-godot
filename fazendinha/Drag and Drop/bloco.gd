extends Control

# Esse sinal avisa o quadrado verde quando você soltar o bloco
signal soltou_bloco(bloco_ref)

var arrastando : bool = false
var offset_clique : Vector2 = Vector2.ZERO

func _process(_delta):
	# Se a variável 'arrastando' for verdadeira, o bloco segue o mouse
	if arrastando:
		global_position = get_global_mouse_position() - offset_clique
		# Chama a função que criamos aqui embaixo para travar o bloco na borda verde
		_prender_no_tabuleiro()

func _gui_input(event):
	# Detecta se o jogador clicou com o botão esquerdo do mouse
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastando = true
			# Guarda a distância de onde você clicou dentro do bloco para o arrasto ficar suave
			offset_clique = get_global_mouse_position() - global_position
			z_index = 10 # Joga o bloco visualmente para a frente de tudo enquanto arrasta
		else:
			arrastando = false
			z_index = 0 # Volta o bloco para a camada normal
			# Dispara o aviso: "Fui solto!"
			emit_signal("soltou_bloco", self)

func _prender_no_tabuleiro():
	var pai = get_parent() as Control
	if pai:
		# Pega os limites exatos (onde começa e termina) o quadrado verde do FundoBlocos
		var limite_min = pai.global_position
		var limite_max = pai.global_position + pai.size - size
		
		# A função clamp() não deixa a posição passar do mínimo nem do máximo.
		# Se você tentar empurrar para fora, ela trava o bloco na borda!
		global_position.x = clamp(global_position.x, limite_min.x, limite_max.x)
		global_position.y = clamp(global_position.y, limite_min.y, limite_max.y)
