extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed = 100
var screen_size

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Change the animation based on the velocity on Y axis
	if velocity.y < -50 :
		$AnimatedSprite2D.animation = "flap"
		rotation_degrees = -30.0
		$AnimatedSprite2D.play()
	elif velocity.y > -50 && velocity.y < 100 :
		rotation_degrees = 0.0
		$AnimatedSprite2D.stop()
	elif velocity.y > 100 && velocity.y < 500 :
		rotation_degrees = 30.0
		$AnimatedSprite2D.stop()
	elif velocity.y > 500:
		rotation_degrees = 60.0
		$AnimatedSprite2D.stop()
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = SPEED

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#direction.x = speed
	#position += direction * delta
	
