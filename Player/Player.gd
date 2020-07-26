extends KinematicBody

enum State {RUNNING, CASTING, IDLE}
onready var _animation:AnimationPlayer = $AnimationPlayer 
onready var _mesh:MeshInstance = $Node/Skeleton/Mesh
onready var _particles1:CPUParticles = $CPUParticles
onready var _particles2:CPUParticles = $CPUParticles2
onready var _particles3:CPUParticles = $CPUParticles3
export var speed = 200
var _casting := false
var spell := {"FIRE":0, "COLD":0, "WATER":0, "SHOCK":0, "HEAL":0, "PROTECT":0, "EARTH":0, "AIR":0}
var state = State.IDLE
signal spell_used

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
	if Input.is_action_just_pressed("Release_Spell"):
		_attack()
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

func _attack():
	var _is_bolt := true if spell["EARTH"] > 0 or spell["AIR"] > 0 else false
	var _is_spray := true if spell["EARTH"] == 0 or spell["AIR"] == 0 or spell["SHOCK"] == 0 else false
	var _is_beam := true if spell["SHOCK"] > 0 and spell["EARTH"] == 0 and spell["AIR"] == 0 else false
	var _is_self := true if spell["HEAL"] > 0 or spell["PROTECT"] > 0 else false
	if _is_self:
		_spell_self()


func _spell_self():
	var _spell_strength = spell["FIRE"]+spell["EARTH"]+spell["COLD"]+spell["HEAL"]+spell["AIR"]+spell["PROTECT"]+spell["SHOCK"]+spell["WATER"]
	if spell["PROTECT"] > 0:
		PlayerVar.armor = (2+spell["FIRE"]+spell["EARTH"]*2+spell["COLD"]+spell["AIR"]+spell["SHOCK"]+spell["WATER"])*10
		_particles1.material_override.albedo_color = Color(1,0.84,0,0.01)
	elif spell["HEAL"] > 0:
		PlayerVar.health += spell.HEAL*20
		if PlayerVar.maxhealth > PlayerVar.health:
			PlayerVar.health = PlayerVar.maxhealth
		_particles1.material_override.albedo_color = Color(0,1,0,0.01)
	for _x in range(0,spell["EARTH"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0.55,0.27,0.07,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(0.55,0.27,0.07,0.01)
	for _x in range(0,spell["AIR"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0.75,0.75,0.75,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(0.75,0.75,0.75,0.01)
	for _x in range(0,spell["WATER"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0,0,1,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(0,0,1,0.01)
	for _x in range(0,spell["SHOCK"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(1,0,1,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(1,0,1,0.01)
	for _x in range(0,spell["FIRE"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(1,0,0,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(1,0,0,0.01)
	for _x in range(0,spell["COLD"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0,1,1,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(0,1,1,0.01)
	for _x in range(0,spell["HEAL"]):
		if _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0,1,0,0.01)
		elif _particles3.material_override.albedo_color == Color(1,1,1,1):
			_particles3.material_override.albedo_color = Color(0,1,0,0.01)
	_particles1.emitting = true
	if _spell_strength > 1:
		_particles2.emitting = true
	if _spell_strength > 2:
		_particles3.emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	_particles1.material_override.albedo_color = Color(1,1,1,1)
	_particles2.material_override.albedo_color = Color(1,1,1,1)
	_particles3.material_override.albedo_color = Color(1,1,1,1)
	emit_signal("spell_used")
	_spell_strength = 0

func _on_Main_update_spell(newspell):
	spell = newspell

func _on_Main_casting(value):
	_casting = value
