extends Node2D #WRITE SPAWNING SYSTEM
var m1911man = preload("res://Scenes/RED/m1911man.tscn")
var daggerdude = preload("res://Scenes/RED/daggerdude.tscn")
var laserpistollad = preload("res://Scenes/RED/laserpistollad.tscn")
var bladedbloke = preload("res://Scenes/RED/bladedbloke.tscn")
var tom = preload("res://Scenes/RED/Tom.tscn")
export (Array, PackedScene) var reds
#these are the available enemies
var rng
var budget = [1, 0, 0, 0, 0] #the amount of points given to the system per tick
var ledgerred = [1, 0, 0, 0, 0] #the current amount of points the system has, decreases per enemy spawned
#we give the system one point to work with so a basic enemy is spawned
var spawnpointsred = []
var counts = []
var point
var enemy
var costs = [1, 10, 20, 30, 40] #these are the costs for each enemy, the first Tom should spawn in after 10 minutes, (40 ticks on medium difficulty)
func _ready():
	rng = RandomNumberGenerator.new()
	ledgerred.resize(5) #There are 5 enemies programmed into the game at the moment, so we have 5 spaces, so the budget per enemy can be tracked individually
	costs.resize(5)
	budget.resize(5)
	counts.resize(5) #The engine doesn't like me not doing this, you win godot
	spawnpointsred = get_tree().get_nodes_in_group("spawnpointsred") #get the locations of all the spawn points
	reds[0] = m1911man
	reds[1] = daggerdude
	reds[2] = laserpistollad
	reds[3] = bladedbloke
	reds[4] = tom
func _on_Timer_timeout():
	for count in range(5):
		budget[count] += 1 #increase the budget
		ledgerred[count] += budget[count] #give the system more spawn points
		counts[count] = int(ledgerred[count] / costs[count]) #work out the number of enemies per rank the system can spawn
		ledgerred[count] -= costs[count] * counts[count] #make the system spend the points it has
		if counts[count] > 0:
			for countII in range(counts[count]):
				point = rand_range(0, 4)
				enemy = reds[count].instance()
				get_node("/root").add_child(enemy)
				enemy.john = $neojohn
				enemy.level = self
				enemy.global_transform = spawnpointsred[point].global_transform
