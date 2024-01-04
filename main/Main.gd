extends Node
@export var ground_file: PackedScene
@export var mob_file: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ground_timer_timeout():
	# If a new node instantiated free the queue and delete it from tree right after (queue_free doesnt immediately delete) before creating a new one.
	# Avoids overloading memory and keeps memory at a constant usage.
	if has_node("NewGround") : 
		get_node("NewGround").queue_free()
		$NewGround.get_parent().remove_child($NewGround)
	
	# Instantiate new Ground node to keep the ground collision (world boundary is bugged).
	var new_ground = ground_file.instantiate()
	add_child(new_ground)
	new_ground.name = "NewGround"
	# Position the new created node underneath the player
	new_ground.get_child(1).position = Vector2($Player.position.x, 418.0)


func _on_mob_spawn_timer_timeout():
	var mob = mob_file.instantiate()
	var mob2 = mob_file.instantiate()
	mob2.rotation_degrees = 180
	var rand_pos = randf_range(350, 550.0)
	mob.position = Vector2($Player.position.x + 300.0, rand_pos)
	mob2.position = Vector2($Player.position.x + 300.0, rand_pos - 100 - 320)
	add_child(mob)
	add_child(mob2)
