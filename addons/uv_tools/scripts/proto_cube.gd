@tool
extends Node3D

## Size of the box mesh and box collision shape
@export var size := Vector3(1,1,1):
	set(value):
		size = value
		if auto_reload:
			_update_size()
	get:
		return size

## Texture to be used for the albedo of the box's surface material
@export var albedo_texture : Texture2D:
	set(value):
		albedo_texture = value
		if auto_reload:
			_update_texture()
	get:
		return albedo_texture

@export_group("Editor Settings")
## Automatically reload the proto node as parameters change
@export var auto_reload = true

## Only reload manually by toggling this export
@export var manual_reload = false:
	set(value):
		_load()

var top_node
var mesh_instance : MeshInstance3D
var mat : StandardMaterial3D

var uv_tools = preload("res://addons/uv_tools/scripts/uv_tools.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_load()

func _update_texture():
	if mesh_instance == null: return
	
	mat.albedo_texture = albedo_texture
	mesh_instance.set_surface_override_material(0, mat)

func _update_uv():
	return uv_tools.cube_project(mesh_instance)

func _update_size():
	if mesh_instance == null: return
	
	var box_mesh = BoxMesh.new()
	box_mesh.size = size
	mesh_instance.mesh = box_mesh
	
	mesh_instance = _update_uv()

func _load():
	if not Engine.is_editor_hint(): return
	
	print("Loading ProtoCube")
	
	var delete = []
	for child in get_children():
		delete.append(child)
		
	for node in delete:
		remove_child(node)
	
	mesh_instance = MeshInstance3D.new()
	mesh_instance.name = "MeshInstance3D"
	
	var box_mesh = BoxMesh.new()
	box_mesh.size = size
	
	mesh_instance.mesh = box_mesh
	
	mat = StandardMaterial3D.new()
	
	if albedo_texture != null:
		mat.albedo_texture = albedo_texture
	
	mesh_instance.set_surface_override_material(0, mat)
	
	add_child(mesh_instance)
	
	mesh_instance = _update_uv()
	
	mesh_instance.owner = get_tree().edited_scene_root

func _process(delta):
	pass
