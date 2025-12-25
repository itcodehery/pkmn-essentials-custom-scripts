#===============================================================================
# Diary UI Scene - Page-Based with Scrolling (Power Red/Green Style)
#===============================================================================

class DiaryScene
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @currentPage = 0
    @scrollY = 0
    @maxScroll = 0
    
    # Power Red and Green Colors
    @baseColor = Color.new(80, 80, 88)      # Dark gray/black
    @shadowColor = Color.new(160, 160, 168) # Light gray shadow
  end
  
  def pbStartScene(diary)
    @diary = diary
    @entries = diary.entries
    
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    begin
      @sprites["background"].setBitmap("Graphics/Pictures/diary_bg")
    rescue
      @sprites["background"].bitmap = Bitmap.new(Graphics.width, Graphics.height)
      # Soft cream background common in GBA menus
      @sprites["background"].bitmap.fill_rect(0, 0, Graphics.width, Graphics.height, Color.new(248, 248, 248))
    end
    
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay = @sprites["overlay"].bitmap
    
    @sprites["pagenum"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @sprites["hints"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    
    pbDrawPage
    pbDrawHints
    return true
  end
  
  def pbDrawPage
    @overlay.clear
    @sprites["pagenum"].bitmap.clear
    
    return if @entries.empty?
    
    entry = @entries[@currentPage]
    
    # UI Layout Constants
    titleY = 40
    dateY = 75
    textStartY = 120
    textX = 40
    textWidth = Graphics.width - 80
    maxVisibleHeight = Graphics.height - 180
    lineHeight = 32
    
    # 1. Draw Static Elements (Title & Date)
    # These move with @scrollY so they scroll away
    pbDrawTextPositions(@sprites["pagenum"].bitmap, [
      [entry[:title], textX, titleY - @scrollY, 0, @baseColor, @shadowColor],
      [entry[:date], textX, dateY - @scrollY, 0, @baseColor, @shadowColor]
    ])
    
    # 2. Wrap and Draw Content
    # Use a dummy bitmap to calculate height
    tempBitmap = Bitmap.new(32, 32)
    wrappedText = wrapText(tempBitmap, entry[:text], textWidth)
    tempBitmap.dispose
    
    textHeight = wrappedText.length * lineHeight
    @maxScroll = [0, (textStartY + textHeight) - (Graphics.height - 60)].max
    
    currentY = textStartY - @scrollY
    wrappedText.each do |line|
      # Only draw if within screen bounds for performance
      if currentY > -lineHeight && currentY < Graphics.height
        pbDrawTextPositions(@overlay, [
          [line, textX, currentY, 0, @baseColor, @shadowColor]
        ])
      end
      currentY += lineHeight
    end
    
    # 3. Draw Page Counter (Static on screen)
    pageText = "Entry #{@currentPage + 1} / #{@entries.length}"
    pbDrawTextPositions(@sprites["pagenum"].bitmap, [
      [pageText, Graphics.width - 40, Graphics.height - 45, 1, @baseColor, @shadowColor]
    ])
  end
  
  def pbDrawHints
    @sprites["hints"].bitmap.clear
    hintY = Graphics.height - 45
    
    if @entries.length > 1
      pbDrawTextPositions(@sprites["hints"].bitmap, [
        ["L: Prev", 40, hintY, 0, @baseColor, @shadowColor],
        ["R: Next", Graphics.width - 160, hintY, 1, @baseColor, @shadowColor]
      ])
    end
    
    if @maxScroll > 0
      pbDrawTextPositions(@sprites["hints"].bitmap, [
        ["SCROLL", Graphics.width / 2, hintY, 2, @baseColor, @shadowColor]
      ])
    end
  end
  
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
    
    # Page Navigation (Trigger)
    if Input.trigger?(Input::RIGHT) && @currentPage < @entries.length - 1
      @currentPage += 1
      @scrollY = 0
      pbPlayCursorSE
      pbDrawPage
      pbDrawHints
    elsif Input.trigger?(Input::LEFT) && @currentPage > 0
      @currentPage -= 1
      @scrollY = 0
      pbPlayCursorSE
      pbDrawPage
      pbDrawHints
    # Scrolling (Repeat for smoothness)
    elsif Input.repeat?(Input::DOWN) && @scrollY < @maxScroll
      @scrollY += 12
      @scrollY = @maxScroll if @scrollY > @maxScroll
      pbDrawPage
    elsif Input.repeat?(Input::UP) && @scrollY > 0
      @scrollY -= 12
      @scrollY = 0 if @scrollY < 0
      pbDrawPage
    elsif Input.trigger?(Input::BACK) || Input.trigger?(Input::USE)
      return false
    end
    
    return true
  end

  def pbEndScene
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def wrapText(bitmap, text, maxWidth)
    return [""] if text.nil? || text.empty?
    paragraphs = text.split("\n")
    allLines = []
    paragraphs.each do |paragraph|
      if paragraph.strip.empty?
        allLines.push("")
        next
      end
      words = paragraph.split(' ')
      currentLine = ""
      words.each do |word|
        testLine = currentLine.empty? ? word : "#{currentLine} #{word}"
        textSize = bitmap.text_size(testLine)
        if textSize.width <= maxWidth
          currentLine = testLine
        else
          allLines.push(currentLine) unless currentLine.empty?
          currentLine = word
        end
      end
      allLines.push(currentLine) unless currentLine.empty?
    end
    return allLines
  end
end

#===============================================================================
# Diary Screen - Main Interface
#===============================================================================

class DiaryScreen
  def initialize(scene)
    @scene = scene
  end
  
  def pbStartScreen(diary)
    @scene.pbStartScene(diary)
    loop do
      Graphics.update
      Input.update
      @scene.pbUpdate
      break unless @scene.pbUpdate
    end
    @scene.pbEndScene
  end
end

#===============================================================================
# Access Function (replaces the old pbAccessDiary)
#===============================================================================

def pbAccessDiary
  diary = pbGetDiary
  
  if diary.entry_count == 0
    pbMessage("The diary sits empty on the desk. I haven't written anything yet.")
    return
  end
  
  scene = DiaryScene.new
  screen = DiaryScreen.new(scene)
  screen.pbStartScreen(diary)
end
