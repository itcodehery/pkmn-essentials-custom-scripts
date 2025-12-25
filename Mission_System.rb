#===============================================================================
# Mission System
# Handles the new Mission System in the Linear Campaign of PKMN Trailokya
#===============================================================================

class Mission
  attr_accessor :id, :name, :description, :status, :reputation_reward, :faction
  
  STATUSES = {
    locked: 0,
    available: 1,
    active: 2,
    completed: 3,
    failed: 4
  }
  
  FACTIONS = {
    asterisk: 0,
    rebel: 1,
    neutral: 2
  }
  
  def initialize(id, name, description, rep_reward = 0, faction = :asterisk)
    @id = id
    @name = name
    @description = description
    @reputation_reward = rep_reward
    @faction = faction
    @status = STATUSES[:locked]
  end
  
  def locked?
    @status == STATUSES[:locked]
  end
  
  def available?
    @status == STATUSES[:available]
  end
  
  def active?
    @status == STATUSES[:active]
  end
  
  def completed?
    @status == STATUSES[:completed]
  end
  
  def failed?
    @status == STATUSES[:failed]
  end
  
  def unlock
    @status = STATUSES[:available]
  end
  
  def start
    @status = STATUSES[:active]
  end
  
  def complete
    @status = STATUSES[:completed]
  end
  
  def fail
    @status = STATUSES[:failed]
  end
  
  def asterisk?
    @faction == :asterisk
  end
  
  def rebel?
    @faction == :rebel
  end
  
  def neutral?
    @faction == :neutral
  end

end

#===============================================================================
# Mission Manager
#===============================================================================

class MissionManager
  attr_reader :missions, :current_mission
  
  def initialize
    @missions = {}
    @current_mission = nil
    setup_missions
  end
  
  def setup_missions
    # Act 1: The Courier (Neutral)
    add_mission(1, "Supply Transport", "Deliver medical supplies to Patala City.", 10, :neutral)
    
    # Act 2: The Mercenary - Asterisk Missions
    add_mission(2, "Redistribution", "Retrieve stolen formula from competitor warehouse.", 15, :asterisk)
    add_mission(3, "Recovery", "Extract client records from Tridock Alpha medical facility.", 20, :asterisk)
    add_mission(4, "Compliance", "Confiscate contaminated product from Seventeen farms.", 25, :asterisk)
    add_mission(5, "Transport", "Intercept illegal trafficking operation near Tridock Beta.", 30, :asterisk)
    
    # Act 3: The Investigator (Asterisk)
    add_mission(6, "Belorg-3 Security Detail", "Provide security at sealed facility inspection.", 50, :asterisk)
    
    # Act 4: The Rebel - Resistance Missions
    add_mission(7, "Sabotage", "Intercept and destroy soul essence transport.", -50, :rebel)
    add_mission(8, "Rescue", "Free captives from processing facility.", -30, :rebel)
    add_mission(9, "Exposition", "Infiltrate Sleepy Hollow operations.", -40, :rebel)
    add_mission(10, "Liberation", "Free captive Pokemon from experimentation.", -35, :rebel)
    
    # Act 5: The Choice (Varies by player decision)
    add_mission(11, "Infiltration", "Final assault on Rio Riteda.", 0, :rebel)
    add_mission(12, "Eternal Service", "Betray resistance, serve Rio Riteda.", 0, :asterisk)
    
    # Mark first mission as completed (intro mission)
    @missions[1].complete
  end
  
  def add_mission(id, name, desc, rep_reward, faction = :asterisk)
    @missions[id] = Mission.new(id, name, desc, rep_reward, faction)
  end
  
  def get_mission(id)
    return @missions[id]
  end
  
def start_mission(id)
    mission = @missions[id]
    return false unless mission && mission.available?
    
    @current_mission = mission
    mission.start
    
    # --- Graphical Notification Start ---
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    # 1. Select the correct graphic based on faction
    bg_filename = case mission.faction
      when :asterisk then "mission_start_asterisk"
      when :rebel    then "mission_start_rebel"
      else "mission_start_neutral" 
    end
    
    bg = Sprite.new(viewport)
    bg.bitmap = load_mission_graphic(bg_filename, 480, 42, Color.new(50, 50, 50, 200))
    bg.x = (Graphics.width - bg.bitmap.width) / 2
    
    img_height = bg.bitmap.height
    bg.y = -img_height 
    
    # 2. Slide Down Animation
    pbSEPlay(get_faction_sound(mission.faction))
    target_y = 0 
    frames = 12
    
    for i in 1..frames
      bg.y = -img_height + ((img_height + target_y) * i / frames)
      Graphics.update
      Input.update
    end
    bg.y = target_y 
    
    # 3. Wait Loop with C-Key (USE) Interrupt
    240.times do
      Graphics.update
      Input.update
      break if Input.trigger?(Input::USE) || Input.trigger?(Input::BACK)
    end
    
    # 4. Slide Up Animation (Exit)
    exit_distance = img_height + target_y + 10
    for i in 1..frames
      bg.y = target_y - (exit_distance * i / frames)
      Graphics.update
      Input.update
    end
    
    # 5. Cleanup
    bg.dispose
    viewport.dispose
    # --- Graphical Notification End ---

    # Optional: Keep the text briefing if you still want the mission description
    pbMessage("\\l[3]MISSION: #{mission.name}")
    pbMessage(mission.description)
    
    return true
  end
  
def unlock_mission(id)
    mission = @missions[id]
    return unless mission
    mission.unlock
    
    # 1. Setup Viewport
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    # 2. Create the Sprite
    bg = Sprite.new(viewport)
    # Corrected for your 480x42 graphic
    bg.bitmap = load_mission_graphic("mission_available_asterisk", 480, 42, Color.new(50, 50, 50, 200))
    bg.x = (Graphics.width - bg.bitmap.width) / 2
    
    img_height = bg.bitmap.height
    bg.y = -img_height 
    
    # 3. Slide Down Animation (16 frames)
    pbSEPlay("Anim/Saint7")
    target_y = 0 
    frames = 16
    
    for i in 1..frames
      bg.y = -img_height + ((img_height + target_y) * i / frames)
      Graphics.update
      Input.update
    end
    bg.y = target_y 
    
    # 4. Stay on screen with C-Key Interrupt
    # We use a loop instead of pbWait to check for Input every frame
    100.times do
      Graphics.update
      Input.update
      # Breaks the loop if C, Space, or Enter is pressed
      break if Input.trigger?(Input::USE) 
    end
    
    # 5. Slide Up Animation (Exit)
    exit_distance = img_height + target_y + 10
    for i in 1..frames
      bg.y = target_y - (exit_distance * i / frames)
      Graphics.update
      Input.update
    end
    
    # 6. Cleanup
    bg.dispose
    viewport.dispose
  end
  
  def complete_current_mission
    return false unless @current_mission && @current_mission.active?
    
    mission = @current_mission
    mission.complete
    
    # Award reputation
    $reputation += mission.reputation_reward
    $reputation = [[$reputation, 0].max, 999].min
    
    show_mission_complete(mission)
    @current_mission = nil
    return true
  end
  
  def fail_current_mission
    return false unless @current_mission && @current_mission.active?
    
    mission = @current_mission
    mission.fail
    show_mission_failed(mission)
    @current_mission = nil
    return true
  end
  
  def show_mission_start(mission)
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    # Select background based on faction
    bg_filename = case mission.faction
      when :asterisk then "mission_start_asterisk"
      when :rebel then "mission_start_rebel"
      else "mission_start_neutral"  # Fallback
    end
    
    # Load faction-specific background
    bg = Sprite.new(viewport)
    bg.bitmap = load_mission_graphic(bg_filename, 480, 100, get_faction_color(mission.faction))
    bg.x = (Graphics.width - bg.bitmap.width) / 2
    bg.y = -bg.bitmap.height
    
    # Text overlay
    text = Sprite.new(viewport)
    text.bitmap = Bitmap.new(bg.bitmap.width - 40, 60)
    text.bitmap.font.name = "Arial"
    text.bitmap.font.size = 20
    text.bitmap.font.bold = true
    text.bitmap.font.color = get_faction_text_color(mission.faction)
    text.x = bg.x + 20
    text.y = -bg.bitmap.height + 20
    
    # Mission header text
    header = mission.rebel? ? "RESISTANCE MISSION" : "MISSION START"
    text.bitmap.draw_text(0, 0, text.bitmap.width, 30, header, 1)
    text.bitmap.font.size = 16
    text.bitmap.font.bold = false
    text.bitmap.draw_text(0, 32, text.bitmap.width, 28, mission.name, 1)
    
    # Animation
    pbSEPlay(get_faction_sound(mission.faction))
    target_y = 20
    20.times do
      bg.y += (target_y - bg.y) * 0.2
      text.y = bg.y + 20
      Graphics.update
    end
    
    pbWait(80)
    
    # Slide out
    20.times do
      bg.y -= 6
      text.y -= 6
      Graphics.update
    end
    
    bg.dispose
    text.dispose
    viewport.dispose
    
    # Briefing
    pbMessage("\\l[3]MISSION: #{mission.name}")
    pbMessage(mission.description)
    if mission.reputation_reward > 0
      pbMessage("Reputation Reward: +#{mission.reputation_reward}")
    elsif mission.reputation_reward < 0
      pbMessage("\\c[1]UCWD Reputation: #{mission.reputation_reward}\\c[0]")
      pbMessage("This mission will harm your standing with UCWD.")
    end
  end
  
  def show_mission_complete(mission)
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    # Select background based on faction
    bg_filename = case mission.faction
      when :asterisk then "mission_complete_asterisk"
      when :rebel then "mission_complete_rebel"
      else "mission_complete_neutral"
    end
    
    bg = Sprite.new(viewport)
    bg.bitmap = load_mission_graphic(bg_filename, 480, 120, get_faction_complete_color(mission.faction))
    bg.x = (Graphics.width - bg.bitmap.width) / 2
    bg.y = -bg.bitmap.height
    
    text = Sprite.new(viewport)
    text.bitmap = Bitmap.new(bg.bitmap.width - 40, 90)
    text.bitmap.font.name = "Arial"
    text.bitmap.font.size = 24
    text.bitmap.font.bold = true
    text.bitmap.font.color = Color.new(255, 255, 255)
    text.x = bg.x + 20
    text.y = -bg.bitmap.height + 15
    
    # Different header for rebel missions
    header = mission.rebel? ? "MISSION SUCCESS" : "MISSION COMPLETE"
    text.bitmap.draw_text(0, 0, text.bitmap.width, 30, header, 1)
    text.bitmap.font.size = 18
    text.bitmap.font.bold = false
    text.bitmap.draw_text(0, 34, text.bitmap.width, 24, mission.name, 1)
    
    # Reputation display
    text.bitmap.font.size = 16
    if mission.reputation_reward > 0
      text.bitmap.font.color = Color.new(100, 255, 100)  # Green
      text.bitmap.draw_text(0, 62, text.bitmap.width, 20, "Reputation +#{mission.reputation_reward}", 1)
    elsif mission.reputation_reward < 0
      text.bitmap.font.color = Color.new(255, 100, 100)  # Red
      text.bitmap.draw_text(0, 62, text.bitmap.width, 20, "UCWD Reputation #{mission.reputation_reward}", 1)
    end
    
    pbMEPlay("Evolution success")
    target_y = 20
    20.times do
      bg.y = lerp(bg.y, target_y, 0.25)
      text.y = bg.y + 15
      Graphics.update
    end
    
    pbWait(100)
    
    20.times do
      bg.y -= 6
      text.y -= 6
      Graphics.update
    end
    
    bg.dispose
    text.dispose
    viewport.dispose
  end
  
  def show_mission_failed(mission)
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    # Select background based on faction
    bg_filename = case mission.faction
      when :asterisk then "mission_failed_asterisk"
      when :rebel then "mission_failed_rebel"
      else "mission_failed_neutral"
    end
    
    bg = Sprite.new(viewport)
    bg.bitmap = load_mission_graphic(bg_filename, 480, 100, Color.new(150, 0, 0, 220))
    bg.x = (Graphics.width - bg.bitmap.width) / 2
    bg.y = -bg.bitmap.height
    
    text = Sprite.new(viewport)
    text.bitmap = Bitmap.new(bg.bitmap.width - 40, 60)
    text.bitmap.font.name = "Arial"
    text.bitmap.font.size = 24
    text.bitmap.font.bold = true
    text.bitmap.font.color = Color.new(255, 255, 255)
    text.x = bg.x + 20
    text.y = -bg.bitmap.height + 20
    
    text.bitmap.draw_text(0, 0, text.bitmap.width, 30, "MISSION FAILED", 1)
    text.bitmap.font.size = 18
    text.bitmap.font.bold = false
    text.bitmap.draw_text(0, 32, text.bitmap.width, 28, mission.name, 1)
    
    pbSEPlay("Battle damage")
    target_y = 20
    20.times do
      bg.y = lerp(bg.y, target_y, 0.2)
      text.y = bg.y + 20
      Graphics.update
    end
    
    pbWait(80)
    
    20.times do
      bg.y -= 6
      text.y -= 6
      Graphics.update
    end
    
    bg.dispose
    text.dispose
    viewport.dispose
  end
  
  def show_mission_complete(mission)
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    bg = Sprite.new(viewport)
    bg.bitmap = Bitmap.new(Graphics.width, 100)
    bg.bitmap.fill_rect(0, 0, Graphics.width, 100, Color.new(0, 100, 0, 220))
    bg.y = -100
    
    text = Sprite.new(viewport)
    text.bitmap = Bitmap.new(Graphics.width - 40, 80)
    text.bitmap.font.name = "Arial"
    text.bitmap.font.size = 28
    text.bitmap.font.bold = true
    text.x = 20
    text.y = -100
    
    text.bitmap.draw_text(0, 0, text.bitmap.width, 35, "MISSION COMPLETE", 1)
    text.bitmap.font.size = 20
    text.bitmap.font.bold = false
    text.bitmap.draw_text(0, 35, text.bitmap.width, 25, mission.name, 1)
    text.bitmap.font.size = 18
    text.bitmap.draw_text(0, 60, text.bitmap.width, 20, "Reputation +#{mission.reputation_reward}", 1)
    
    pbMEPlay("Evolution success")
    20.times do
      bg.y += 5
      text.y += 5
      Graphics.update
    end
    
    pbWait(100)
    
    20.times do
      bg.y -= 5
      text.y -= 5
      Graphics.update
    end
    
    bg.dispose
    text.dispose
    viewport.dispose
  end
  
  def show_mission_failed(mission)
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    
    bg = Sprite.new(viewport)
    bg.bitmap = Bitmap.new(Graphics.width, 80)
    bg.bitmap.fill_rect(0, 0, Graphics.width, 80, Color.new(150, 0, 0, 220))
    bg.y = -80
    
    text = Sprite.new(viewport)
    text.bitmap = Bitmap.new(Graphics.width - 40, 60)
    text.bitmap.font.name = "Arial"
    text.bitmap.font.size = 24
    text.bitmap.font.bold = true
    text.x = 20
    text.y = -80
    
    text.bitmap.draw_text(0, 0, text.bitmap.width, 30, "MISSION FAILED", 1)
    text.bitmap.font.size = 18
    text.bitmap.font.bold = false
    text.bitmap.draw_text(0, 30, text.bitmap.width, 30, mission.name, 1)
    
    pbSEPlay("Battle damage")
    20.times do
      bg.y += 4
      text.y += 4
      Graphics.update
    end
    
    pbWait(80)
    
    20.times do
      bg.y -= 4
      text.y -= 4
      Graphics.update
    end
    
    bg.dispose
    text.dispose
    viewport.dispose
  end
  
  def get_completed_count
    return @missions.values.count { |m| m.completed? }
  end
  
  def get_available_missions
    return @missions.values.select { |m| m.available? }
  end
  
    def load_mission_graphic(filename, width, height, fallback_color)
    path = "Graphics/Pictures/#{filename}"
    if pbResolveBitmap(path)
      return Bitmap.new(path)
    else
      # Create fallback colored rectangle
      bitmap = Bitmap.new(width, height)
      bitmap.fill_rect(0, 0, width, height, fallback_color)
      # Add border
      bitmap.fill_rect(0, 0, width, 2, Color.new(255, 255, 255, 100))
      bitmap.fill_rect(0, height-2, width, 2, Color.new(255, 255, 255, 100))
      bitmap.fill_rect(0, 0, 2, height, Color.new(255, 255, 255, 100))
      bitmap.fill_rect(width-2, 0, 2, height, Color.new(255, 255, 255, 100))
      return bitmap
    end
  end
  
  def get_faction_color(faction)
    case faction
    when :asterisk
      return Color.new(20, 60, 100, 230)  # Cool blue
    when :rebel
      return Color.new(100, 40, 20, 230)  # Warm orange/red
    else
      return Color.new(60, 60, 60, 230)   # Neutral gray
    end
  end
  
  def get_faction_complete_color(faction)
    case faction
    when :asterisk
      return Color.new(20, 100, 60, 230)  # Corporate green
    when :rebel
      return Color.new(120, 80, 20, 230)  # Resistance gold
    else
      return Color.new(60, 100, 60, 230)  # Neutral green
    end
  end
  
  def get_faction_text_color(faction)
    case faction
    when :asterisk
      return Color.new(200, 230, 255)     # Cold blue-white
    when :rebel
      return Color.new(255, 220, 180)     # Warm orange-white
    else
      return Color.new(255, 255, 255)     # Pure white
    end
  end
  
  def get_faction_sound(faction)
    case faction
    when :asterisk
      return "Anim/Saint7"                # Clean, digital
    when :rebel
      return "Anim/Psych Up"             # Grittier sound
    else
      return "Anim/Saint7"
    end
  end
end

#===============================================================================
# Global Mission Manager Access
#===============================================================================

def pbMissionManager
  $mission_manager = MissionManager.new if !$mission_manager
  return $mission_manager
end

# Helper functions for events
def pbStartMission(id)
  pbMissionManager.start_mission(id)
end

def pbCompleteMission
  pbMissionManager.complete_current_mission
end

def pbFailMission
  pbMissionManager.fail_current_mission
end

def pbUnlockMission(id)
  pbMissionManager.unlock_mission(id)
end

def pbGetCurrentMission
  return pbMissionManager.current_mission
end

def pbMissionActive?(id)
  mission = pbMissionManager.get_mission(id)
  return mission && mission.active?
end

def pbMissionCompleted?(id)
  mission = pbMissionManager.get_mission(id)
  return mission && mission.completed?
end

# -------------------------------------------------
# Helper Functions for the Player Factions
# -------------------------------------------------

# Get current faction alignment
def pbGetFaction
  return $faction_alignment || :asterisk
end

# Switch faction (for Act 3 transition)
def pbSwitchFaction(new_faction)
  old_faction = $faction_alignment
  $faction_alignment = new_faction
  
  case new_faction
  when :rebel
    pbMessage("\\l[3]FACTION CHANGED")
    pbMessage("You are now aligned with the Resistance.")
    pbMessage("UCWD will consider you hostile.")
  when :asterisk
    pbMessage("\\l[3]FACTION CHANGED")
    pbMessage("You are now aligned with Asterisk.")
  end
end

# Check faction alignment
def pbIsAsterisk?
  return pbGetFaction == :asterisk
end

def pbIsRebel?
  return pbGetFaction == :rebel
end

# Save Integration for Missions
SaveData.register(:mission_manager) do
  ensure_class :MissionManager
  save_value { $mission_manager }
  load_value { |value| $mission_manager = value }
  new_game_value { MissionManager.new }
end
