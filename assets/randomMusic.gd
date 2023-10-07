extends Node

var TRACKS = [
	"flop",
	"crystal",
	"battlew"
]

func _ready() -> void:
	randomize()
	shuffle_songs ()
	
func play_music(song: AudioStream) -> void:
	$MainTheme.stream = song
	$MainTheme.play( )

func shuffle_songs() -> void:
	TRACKS.shuffle()
	var song_index = randi() % TRACKS.size()
	var audio_stream: AudioStream = load('res://sound/music/' + TRACKS[song_index] + '.mp3')
	play_music(audio_stream)

func _on_MainTheme_finished() -> void:
	shuffle_songs( )
