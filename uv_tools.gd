@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("ProtoCube", "MeshInstance3D", preload("scripts/cube_project.gd"), preload("icon.svg"))
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("ProtoCube")
	pass
