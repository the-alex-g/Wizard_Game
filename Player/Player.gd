extends KinematicBody

enum State {RUNNING, CASTING, IDLE}
onready var _animation:AnimationPlayer = $AnimationPlayer 
export var speed = 200
var is_casting := false
var spell := {"fire":0, "cold":0, "water":0, "shock":0, "heal":0, "protect":0, "earth":0, "air":0}
var state = State.IDLE

func _physics_process(delta):
	var _velocity := Vector3(0,0,0)
	if not is_casting:
		if Input.is_action_pressed("Forward"):
			_velocity.z += 1
		if Input.is_action_pressed("Backward"):
			_velocity.z -= 1
		if Input.is_action_pressed("Left"):
			_velocity.x += 1
		if Input.is_action_pressed("Right"):
			_velocity.x -= 1
	_velocity = _velocity.normalized()
	_velocity *= speed*delta
	if _velocity.length_squared() > 0:
		state = State.RUNNING
	else:
		state = State.IDLE
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
