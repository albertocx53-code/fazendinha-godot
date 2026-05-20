extends CharacterBody2D

@export var speed = 200

var comandos = []
var tempo = 0
var intervalo = 0.2

func _process(delta):

	if Input.is_action_just_pressed("ui_up"):
		comandos.append("cima")

	if Input.is_action_just_pressed("ui_down"):
		comandos.append("baixo")

	if Input.is_action_just_pressed("ui_left"):
		comandos.append("esquerda")

	if Input.is_action_just_pressed("ui_right"):
		comandos.append("direita")

	tempo += delta

	if tempo >= intervalo:
		executar_comando()
		tempo = 0

func executar_comando():

	if comandos.size() == 0:
		return

	var comando = comandos.pop_front()

	match comando:

		"cima":
			position.y -= 50

		"baixo":
			position.y += 50

		"esquerda":
			position.x -= 50

		"direita":
			position.x += 50
