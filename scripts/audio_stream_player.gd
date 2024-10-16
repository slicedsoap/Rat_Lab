extends AudioStreamPlayer

const level_music = preload("res://music/Vibing Over Venus.mp3")

func play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music 
	volume_db = volume
	play()
	
func play_music_level():
	play_music(level_music)
