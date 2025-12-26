class TextLog_Scene
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @index = 0
    # Match Diary Colors and Font
    @fontName = "Power Red and Green"
    @fontSize = 28
    @baseColor = Color.new(80, 80, 88)
    @shadowColor = Color.new(160, 160, 168)
  end

  def pbStartScene
    @log_data = pbGetTextLogs.logs.values
    @sprites["bg"] = IconSprite.new(0, 0, @viewport)
    @sprites["bg"].setBitmap("Graphics/Pictures/diary_bg")
    
    # 1. Left side List
    @sprites["list"] = Window_CommandPokemon.new([])
    @sprites["list"].viewport = @viewport
    @sprites["list"].width = 240
    @sprites["list"].height = Graphics.height - 100
    @sprites["list"].x = 30
    @sprites["list"].y = 50
    @sprites["list"].opacity = 0
    @sprites["list"].baseColor = @baseColor
    @sprites["list"].shadowColor = @shadowColor
    
    # 2. Right side Text Overlay (Clipped like the Diary)
    @viewWidth = Graphics.width - 320
    @viewHeight = Graphics.height - 120
    @sprites["text_overlay"] = BitmapSprite.new(@viewWidth, @viewHeight, @viewport)
    @sprites["text_overlay"].x = 290
    @sprites["text_overlay"].y = 60
    @overlay = @sprites["text_overlay"].bitmap
    
    # Apply font to both
    @sprites["list"].contents.font.name = @fontName
    @sprites["list"].contents.font.size = @fontSize
    @overlay.font.name = @fontName
    @overlay.font.size = @fontSize
    
    pbUpdateDisplay
  end

  def pbUpdateDisplay
    commands = @log_data.map { |l| l[:title] }
    @sprites["list"].commands = commands
    draw_current_log
  end

  def draw_current_log
    @overlay.clear
    return if @log_data.empty?
    
    # Get the currently selected log
    log = @log_data[@sprites["list"].index]
    
    # NEW: Mark as read in the system
    pbGetTextLogs.mark_as_read(log[:id])
    
    # Header: Faction Tag
    faction_tag = "[#{log[:faction].to_s.upcase}]"
    pbDrawTextPositions(@overlay, [[faction_tag, 0, 0, 0, @baseColor, @shadowColor]])
    
    # Content
    drawTextEx(@overlay, 0, 40, @viewWidth, 2, log[:text], @baseColor, @shadowColor)
  end

  def pbScene
    loop do
      Graphics.update
      Input.update
      old_index = @sprites["list"].index
      @sprites["list"].update
      draw_current_log if @sprites["list"].index != old_index
      
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
