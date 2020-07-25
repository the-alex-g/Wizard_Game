extends KinematicBody

enum State {RUNNING, CASTING, IDLE}
onready var _animation:AnimationPlayer = $AnimationPlayer 
onready var _mesh:MeshInstance = $Node/Skeleton/Mesh
export var speed = 200
var _casting := false
var spell := {"FIRE":0, "COLD":0, "WATER":0, "SHOCK":0, "HEAL":0, "PROTECT":0, "EARTH":0, "AIR":0}
var state = State.IDLE

func _physics_process(delta):
	var _velocity := Vector3(0,0,0)
	if not _casting:
		if Input.is_action_pressed("Forward"):
			_velocity.z += 1
		if Input.is_action_pressed("Backward"):
			_velocity.z -= 1
		if Input.is_action_pressed("Left"):
			_velocity.x += 1
		if Input.is_action_pressed("Right"):
			_velocity.x -= 1
	if _velocity.length_squared() > 0:
		state = State.RUNNING
		var _dir := Vector2(0,0)
		if _velocity.x == 1:
			_dir.x -= 1
		if _velocity.x == -1:
			_dir.x += 1
		if _velocity.z == 1:
			_dir.y += 1
		if _velocity.z == -1:
			_dir.y -= 1
		var _angle:float = rad2deg(_dir.angle())-90
		_mesh.rotation_degrees = Vector3(0,_angle,0)
	else:
		state = State.IDLE
	_velocity = _velocity.normalized()
	_velocity *= speed*delta
	var _error = move_and_slide_with_snap(_velocity*speed*delta, Vector3.DOWN, Vector3.UP)
	var _next_anim:String = _get_animation()
	_animation.play(_next_anim)

func _get_animation():
	var _new_anim := ""
	if state == State.IDLE:
		_new_anim = "Idle"
	if state == State.RUNNING:
		_new_anim = "Running"
	if state == State.CASTING:
		_new_anim = "Cast"
	return _new_anim

func _on_Main_update_spell(newspell):
	spell = newspell

func _on_Main_casting(value):
	_casting = value
