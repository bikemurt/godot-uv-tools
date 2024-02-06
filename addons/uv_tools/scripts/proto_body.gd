@tool
extends Node3D

## Body type. If this is changed the entire node will be reloaded
@export_enum("Static Body", "Rigid Body") var body_type : int = 0:
	set(value):
		body_type = value
		if auto_reload:
			_load()
	get:
		return body_type

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
var collision_shape : CollisionShape3D
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
	
	var box_shape = collision_shape.shape
	if box_shape != null:
		box_shape.size = size

func _load():
	if not Engine.is_editor_hint(): return
	
	print("Loading ProtoBody")
	
	var delete = []
	for child in get_children():
		delete.append(child)
		
	for node in delete:
		node.queue_free()
		remove_child(node)
	
	var top_node
	if body_type == 0:
		top_node = StaticBody3D.new()
		top_node.name = "StaticBody3D"
	if body_type == 1:
		top_node = RigidBody3D.new()
		top_node.name = "RigidBody3D"
	
	collision_shape = CollisionShape3D.new()
	collision_shape.name = "CollisionShape3D"
	
	var box_shape = BoxShape3D.new()
	box_shape.size = size
	collision_shape.shape = box_shape
	
	mesh_instance = MeshInstance3D.new()
	mesh_instance.name = "MeshInstance3D"
	
	var box_mesh = BoxMesh.new()
	box_mesh.size = size
	
	mesh_instance.mesh = box_mesh
	
	mat = StandardMaterial3D.new()
	
	if albedo_texture != null:
		mat.albedo_texture = albedo_texture
	
	mesh_instance.set_surface_override_material(0, mat)
	
	top_node.add_child(collision_shape)
	top_node.add_child(mesh_instance)
	
	add_child(top_node)
	
	mesh_instance = _update_uv()
	
	var set_roots = [top_node, collision_shape, mesh_instance]
	for node in set_roots:
		node.owner = get_tree().edited_scene_root

func _process(delta):
	pass
