@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ProtoCube", "MeshInstance3D", preload("scripts/proto_cube.gd"), preload("icons/proto_cube.svg"))
	add_custom_type("ProtoBody", "Node3D", preload("scripts/proto_body.gd"), preload("icons/proto_body.svg"))

func _exit_tree():
	remove_custom_type("ProtoCube")
	remove_custom_type("ProtoBody")
