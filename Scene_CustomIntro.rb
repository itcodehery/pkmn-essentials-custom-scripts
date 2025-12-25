class Scene_CustomIntro
  def main
    Game.start_new_game
    
    # Set Arya's details
    $player.name = "Arya"
    $player.gender = 1
    $player.money = 5000
    $mission_manager = MissionManager.new
    $reputation = 100
    
    # Give starter Pokemon
    pkmn = Pokemon.new(:SQUIRTLE, 15)
    pkmn.happiness = 255
    $player.party.push(pkmn)
    
    $game_temp.player_new_map_id = 22  
    $game_temp.player_new_x = 11
    $game_temp.player_new_y = 8
    $game_temp.player_new_direction = 2  # Facing down
    
    $scene = Scene_Map.new
  end
end
