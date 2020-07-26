extends Area

onready var _sphere:MeshInstance = $MeshInstance
onready var _particles1 = $MeshInstance/CPUParticles
onready var _particles2 = $MeshInstance/CPUParticles2
var spell := {"FIRE":0, "COLD":0, "WATER":0, "SHOCK":0, "HEAL":0, "PROTECT":0, "EARTH":0, "AIR":0}
var speed := 400

func _ready():
	var _spell_strength:int
	_spell_strength = spell["FIRE"]+spell["EARTH"]+spell["COLD"]+spell["HEAL"]+spell["AIR"]+spell["PROTECT"]+spell["SHOCK"]+spell["WATER"]
	var size := 0.1
	for _x in _spell_strength-1:
		size += 0.05
	_sphere.scale = Vector3(size,size,size)
	if spell["EARTH"] > 0:
		_sphere.material_override.albedo_color = Color(0.55,0.27,0.07,1)
	if spell["AIR"] > 0:
		_sphere.material_override.albedo_color = Color(0.75,0.75,0.75,1)
	if _spell_strength == 3:
		_particles1.emitting = true
		_particles2.emitting = true
	elif _spell_strength == 2:
		_particles1.emitting = true
	for x in range(0,spell["EARTH"]-1):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(0.55,0.27,0.07,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0.55,0.27,0.07,1)
	for x in range(0,spell["AIR"]-1):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(0.75,0.75,0.75,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0.75,0.75,0.75,1)
	for x in range(0,spell["WATER"]):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(0,0,1,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0,0,1,1)
	for x in range(0,spell["SHOCK"]):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(1,0,1,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(1,0,1,1)
	for x in range(0,spell["FIRE"]):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(1,0,0,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(1,0,0,1)
	for x in range(0,spell["COLD"]):
		if _particles1.material_override.albedo_color == Color(1,1,1,1):
			_particles1.material_override.albedo_color = Color(0,1,1,1)
		elif _particles2.material_override.albedo_color == Color(1,1,1,1):
			_particles2.material_override.albedo_color = Color(0,1,1,1)
