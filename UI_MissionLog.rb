#===============================================================================
# Mission Log Screen
#===============================================================================
class PokemonMissionLog_Scene
  def pbStartScene
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    
    # 1. Load Custom Background PNG
    @sprites["bg"] = Sprite.new(@viewport)
    @sprites["bg"].bitmap = Bitmap.new("Graphics/Pictures/mission_log_bg")
    
    # 2. Mission List (Windowless / Invisible Background)
    @sprites["list"] = Window_CommandPokemon.new([])
    @sprites["list"].viewport = @viewport
    @sprites["list"].width = 260 
    @sprites["list"].height = 200 
    @sprites["list"].x = 10
    @sprites["list"].y = 120 
    @sprites["list"].opacity = 0 # Makes the window border/bg invisible
    @sprites["list"].baseColor = Color.new(255, 255, 255)   # List text color
    @sprites["list"].shadowColor = Color.new(0, 0, 0)       # List shadow color
    
    # 3. Mission Description (Drawn directly on an overlay bitmap)
    @sprites["desc_overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @desc_bitmap = @sprites["desc_overlay"].bitmap
    pbSetSystemFont(@desc_bitmap)
    
    @missions_data = [] 
    pbUpdateDisplay
  end

  def pbUpdateDisplay
    manager = pbMissionManager
    commands = []
    @missions_data = []
    
    sorted_missions = manager.missions.keys.sort
    for id in sorted_missions
      mission = manager.missions[id]
      next if mission.locked?
      
      status = case mission.status
        when Mission::STATUSES[:completed] then "OK"
        when Mission::STATUSES[:active]    then "-"
        when Mission::STATUSES[:failed]    then "X"
        else "!!"
      end
      
      commands.push("#{status} #{mission.name}")
      @missions_data.push(mission)
    end
    
    @sprites["list"].commands = commands
    update_description 
  end

  def update_description
    @desc_bitmap.clear
    index = @sprites["list"].index
    return if !@missions_data[index]
    
    mission = @missions_data[index]
    # base_color = Color.new(225, 122, 67)
    base_color = Color.new(255, 255, 255)
    shadow_color = Color.new(43, 43, 43)
    status = case mission.status
        when Mission::STATUSES[:completed] then "Completed"
        when Mission::STATUSES[:active]    then "Active"
        when Mission::STATUSES[:failed]    then "Failed"
        else "Available"
      end
    
    # Text coordinates for the description (Right side of your UI)
    desc_x = 280
    desc_y = 130
    desc_width = 200
    
    # Use drawFormattedTextEx to render tags like <c2> or <b> without a window
    drawFormattedTextEx(@desc_bitmap, desc_x, desc_y, desc_width,
      "<ac><b>#{mission.name}</b></ac><br>#{mission.description}<br><b>#{status}</b>",
      base_color, shadow_color)
  end

  def pbScene
    old_index = @sprites["list"].index
    loop do
      Graphics.update
      Input.update
      @sprites["list"].update
      
      if @sprites["list"].index != old_index
        update_description
        old_index = @sprites["list"].index
      end
      
      if Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        break
      end
    end
  end

  def pbEndScene
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

# ------------------DON'T MODIFY THIS HARI----------------------

class PokemonMissionLogScreen
  def initialize(scene)
    @scene = scene
  end
  
  def pbStartScreen
    @scene.pbStartScene
    @scene.pbScene
    @scene.pbEndScene
  end
end

def pbMissionLog
  scene = PokemonMissionLog_Scene.new
  screen = PokemonMissionLogScreen.new(scene)
  screen.pbStartScreen
end
