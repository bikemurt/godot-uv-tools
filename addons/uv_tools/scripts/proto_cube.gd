@tool
extends MeshInstance3D

@export var auto_update = true
@export var manual_reload = false:
	set(value):
		_load_mesh()

func _ready():
	_load_mesh()

func _load_mesh():
	if not Engine.is_editor_hint():
		return
	
	var new_mesh = ArrayMesh.new()
	new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, BoxMesh.new().get_mesh_arrays())
	
	var mdt = MeshDataTool.new()
	mdt.create_from_surface(new_mesh, 0)
	
	for i in range(mdt.get_face_count()):
		var normal = mdt.get_face_normal(i)
		
		var idx_0 = mdt.get_face_vertex(i, 0)
		var idx_1 = mdt.get_face_vertex(i, 1)
		var idx_2 = mdt.get_face_vertex(i, 2)
		
		var v0 = mdt.get_vertex(idx_0)
		var v1 = mdt.get_vertex(idx_1)
		var v2 = mdt.get_vertex(idx_2)
		
		if normal.x != 0:
			# use y and z
			var p0 = Vector2(v0.y, v0.z)
			var p1 = Vector2(v1.y, v1.z)
			var p2 = Vector2(v2.y, v2.z)
			
			var scale_uv = Vector2(scale.y, scale.z)
			
			p0 *= scale_uv
			p1 *= scale_uv
			p2 *= scale_uv
			
			var uv0 = Vector2(p0.x + 0.5, p0.y + 0.5)
			var uv1 = Vector2(p1.x + 0.5, p1.y + 0.5)
			var uv2 = Vector2(p2.x + 0.5, p2.y + 0.5)
			
			mdt.set_vertex_uv(idx_0, uv0)
			mdt.set_vertex_uv(idx_1, uv1)
			mdt.set_vertex_uv(idx_2, uv2)
		
		if normal.y != 0:
			# use x and z
			var p0 = Vector2(v0.x, v0.z)
			var p1 = Vector2(v1.x, v1.z)
			var p2 = Vector2(v2.x, v2.z)
			
			var scale_uv = Vector2(scale.x, scale.z)
			
			p0 *= scale_uv
			p1 *= scale_uv
			p2 *= scale_uv
			
			var uv0 = Vector2(p0.x + 0.5, p0.y + 0.5)
			var uv1 = Vector2(p1.x + 0.5, p1.y + 0.5)
			var uv2 = Vector2(p2.x + 0.5, p2.y + 0.5)
			
			mdt.set_vertex_uv(idx_0, uv0)
			mdt.set_vertex_uv(idx_1, uv1)
			mdt.set_vertex_uv(idx_2, uv2)
			
		if normal.z != 0:
			# use x and y
			var p0 = Vector2(v0.x, v0.y)
			var p1 = Vector2(v1.x, v1.y)
			var p2 = Vector2(v2.x, v2.y)
			
			var scale_uv = Vector2(scale.x, scale.y)
			
			p0 *= scale_uv
			p1 *= scale_uv
			p2 *= scale_uv
			
			var uv0 = Vector2(p0.x + 0.5, p0.y + 0.5)
			var uv1 = Vector2(p1.x + 0.5, p1.y + 0.5)
			var uv2 = Vector2(p2.x + 0.5, p2.y + 0.5)
			
			mdt.set_vertex_uv(idx_0, uv0)
			mdt.set_vertex_uv(idx_1, uv1)
			mdt.set_vertex_uv(idx_2, uv2)
	
	new_mesh.clear_surfaces()
	mdt.commit_to_surface(new_mesh)
	
	mesh = new_mesh
	
	if get_surface_override_material(0) == null:
		var mat = StandardMaterial3D.new()
		set_surface_override_material(0, mat)

var last_scale = scale
func _process(delta):
	if Engine.is_editor_hint():
		if last_scale != scale:
			if auto_update:
				_load_mesh()
		last_scale = scale
