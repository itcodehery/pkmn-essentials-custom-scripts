class TextLog
  attr_accessor :logs, :read_logs # Added read_logs

  def initialize
    @logs = {} 
    @read_logs = [] # Initialize empty list of read logs
  end

  def add_log(id, title, text, faction = :neutral)
    @logs[id] = { :id => id, :title => title, :text => text, :faction => faction }
  end

  def has_log?(id)
    return @logs.has_key?(id)
  end

  # Check if there are any unread logs
  def any_unread?
    return @logs.keys.any? { |id| !@read_logs.include?(id) }
  end

  # Mark a specific log as read
  def mark_as_read(id)
    @read_logs.push(id) if !@read_logs.include?(id)
  end
end

class PokemonGlobalMetadata
  attr_accessor :text_logs
end

def pbGetTextLogs
  if !$PokemonGlobal.text_logs || !$PokemonGlobal.text_logs.is_a?(TextLog)
    $PokemonGlobal.text_logs = TextLog.new
  end
  return $PokemonGlobal.text_logs
end

# Use this in events: pbCollectLog(1, "Old Note", "The formula was lost in 2025...")
def pbCollectLog(id, title, text, faction = :neutral)
  logs = pbGetTextLogs
  return if logs.has_log?(id)
  logs.add_log(id, title, text, faction)
  pbMessage(_INTL("Collected Text Log: {1}!", title))
end
