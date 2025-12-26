#===============================================================================
# Diary System for Pokemon Essentials
#===============================================================================

class Diary
  attr_accessor :entries
  
  def initialize
    @entries = []
  end
  
  # Add a new diary entry silently with a futuristic date
  def add_entry(title, text)
    # Get the current time and advance it by 100 years
    future_year = pbGetTimeNow.year + 100
    # Format the date manually to use the futuristic year
    futuristic_date = pbGetTimeNow.strftime("%B %d, ") + future_year.to_s
    
    @entries.push({
      :title => title,
      :text  => text,
      :date  => futuristic_date
    })
  end
  
  # Check if an entry exists
  def has_entry?(index)
    return index >= 0 && index < @entries.length
  end
  
  # Get total entries
  def entry_count
    return @entries.length
  end
end

#===============================================================================
# Global diary access
#===============================================================================

# Add diary attribute to PokemonGlobalMetadata
class PokemonGlobalMetadata
  attr_accessor :diary
end

def pbGetDiary
  if !$PokemonGlobal.diary || !$PokemonGlobal.diary.is_a?(Diary)
    $PokemonGlobal.diary = Diary.new
  end
  return $PokemonGlobal.diary
end

#===============================================================================
# Silent diary entry addition (no message)
#===============================================================================

def pbAddDiaryEntry(title, text)
  diary = pbGetDiary
  diary.add_entry(title, text)
end

#===============================================================================
# STORY DIARY ENTRIES
#===============================================================================

# ACT 1: THE COURIER
#===============================================================================

def pbDiary_Act1_Opening
  pbAddDiaryEntry("Day 1 - Oasis", 
    "Another transport job lined up. Medical supplies from Vytrana Dock to Central Sphere. \
The pay is good, and I don't ask questions anymore. That's the key to surviving in this line of work.\n\n\
My partner seems restless today. I don't know why I keep calling them that. They're just a Pokemon. \
But sometimes, when I look at them, I feel like they understand something I don't.")
end

def pbDiary_Act1_FirstDelivery
  pbAddDiaryEntry("Day 3 - Vytrana Dock", 
    "Cargo secured. The containers are marked as 'therapeutic compounds for post-Collapse trauma treatment.' \
Heavy security for medical supplies, but I suppose that's normal these days. Everything's scarce after the Collapse.\n\n\
The dock workers wouldn't look me in the eye when loading the containers. \
My partner kept pawing at one of the crates. I had to pull them away.\n\n\
Just a job. Just another job.")
end

def pbDiary_Act1_CentralSphereArrival
  pbAddDiaryEntry("Day 7 - Central Sphere", 
    "Made it to Central Sphere. Marseilles is still a ghost of what it was before the attack. \
The UCWD keeps the essential districts running, but you can feel the weight of martial law everywhere.\n\n\
Delivery went smoothly. Client seemed pleased. They offered me more work - 'specialized acquisitions' \
they called it. The money is too good to refuse.\n\n\
My partner has been acting strange since we arrived. They keep staring at people like they're trying \
to see through them. I need to get them checked out.")
end

#===============================================================================
# ACT 2: THE MERCENARY
#===============================================================================

def pbDiary_Act2_Mission1_Before
  pbAddDiaryEntry("Week 2 - New Assignment", 
    "First job for the new client. Warehouse district, simple retrieval. \
They say a competitor stole their pharmaceutical patents. Corporate espionage is messy, \
but it's not my problem. I just need to get in, get the samples, get out.\n\n\
Reminds me of the old days. The mercenary days. There was a clarity to it - objectives, \
execution, payment. No moral ambiguity. No questions.\n\n\
Why does that feel like a lie?")
end

def pbDiary_Act2_Mission1_After
  pbAddDiaryEntry("Week 2 - First Heist Complete", 
    "Job done. Clean execution. The security team never knew what hit them.\n\n\
But my partner... they hesitated when facing the guards' Pokemon. Had to order them twice \
before they'd engage. That's not like them. They've never questioned an order before.\n\n\
The guards kept shouting something about 'you don't know what you're stealing.' \
Typical corporate dramatics. Everyone thinks their product is world-changing.\n\n\
Still. The way my partner looked at those containers. Like they recognized something.")
end

def pbDiary_Act2_Mission2_Before
  pbAddDiaryEntry("Week 4 - Tridock Alpha", 
    "Moving up in the world. Literally. Client wants data from a luxury medical facility in \
the upper district of Tridock Alpha. The kind of place where the wealthy go to forget the Collapse ever happened.\n\n\
Met some other freelancers at the briefing. Professional types. We didn't exchange names. \
That's how you know it's serious work.\n\n\
My partner hasn't been eating well. I'm worried about them.")
end

def pbDiary_Act2_Mission2_After
  pbAddDiaryEntry("Week 4 - Questions", 
    "The job went wrong. Not the execution - that was perfect. But the target...\n\n\
She was a doctor. When I pulled the data, she grabbed my arm and said, 'Please, they're harvesting us. \
You have to stop them.' Her eyes... there was real terror there.\n\n\
I told myself it was corporate espionage paranoia. Rival companies trying to poach talent. \
But I keep seeing her face.\n\n\
My partner wouldn't leave her side until I dragged them out. They've never done that before.")
end

def pbDiary_Act2_Mission3_Before
  pbAddDiaryEntry("Week 6 - Seventeen", 
    "Agricultural colony job. Supposedly the farming operation is producing contaminated product. \
Health hazard. Public safety risk. We're supposed to confiscate the entire harvest.\n\n\
Something about this one feels off. But the money is substantial. And I'm good at not asking questions.\n\n\
That's what I keep telling myself.")
end

def pbDiary_Act2_Mission3_After
  pbAddDiaryEntry("Week 6 - The Farmers", 
    "I can't stop thinking about them.\n\n\
The farmers weren't producing contaminated product. Their crops were thriving. Their Pokemon were... \
I don't know how to describe it. Vibrant. Alive in a way I haven't seen since before the Collapse.\n\n\
My partner refused to fight. Actually REFUSED. I gave the order and they just sat down and \
looked at me like I was asking them to do something unforgivable.\n\n\
One of the farmers said something before we left: 'Your Pokemon remembers what you've forgotten.'\n\n\
What does that mean?")
end

def pbDiary_Act2_Mission4_Before
  pbAddDiaryEntry("Week 8 - Intercepting Volunteers", 
    "They're calling it a rescue operation. Human trafficking ring moving 'volunteers' from \
Tridock Beta to Oasis. We're supposed to intercept and secure the victims.\n\n\
Finally, a job that feels right. Taking down traffickers. Saving people. \
This is why I left the mercenary life. To do something that matters.\n\n\
My partner seems agitated. Maybe they sense the danger.")
end

def pbDiary_Act2_Mission4_After
  pbAddDiaryEntry("Week 8 - What Have I Done", 
    "They weren't being rescued. They were already captured.\n\n\
The cargo hold... there were people in there. Sedated. Labeled like livestock. And Pokemon - \
separated from their trainers, crying, traumatized.\n\n\
One of them was Ghost-type. Or... it used to be something else. I could see the corruption in it. \
The wrongness. It looked at my partner and they both just... knew each other somehow.\n\n\
My handler called. Said the 'volunteers' were for medical trials. Consented. Legal.\n\n\
I took the Ghost Pokemon. I don't know why. I just couldn't leave it there.\n\n\
What have I been doing? What have I been HELPING with?")
end

def pbDiary_Act2_BeforeAct3
  pbAddDiaryEntry("Week 9 - The Truth Knocks", 
    "Big payday came through. Biggest yet. New assignment: Security detail at Belorg-3 facility. \
'Routine inspection' of a sealed site.\n\n\
I should be celebrating. Instead, I'm staring at this Ghost Pokemon, watching it curl up next to my partner, \
and wondering how I didn't see it before.\n\n\
Someone approached me at the market today. Resistance member. They said: 'You don't know what you've been doing, do you?'\n\n\
I didn't answer. Because I'm starting to realize I don't.\n\n\
Belorg-3. Why does that name make my head hurt?")
end

#===============================================================================
# ACT 3: THE INVESTIGATOR
#===============================================================================

def pbDiary_Act3_ArrivalBelorg3
  pbAddDiaryEntry("Week 10 - Belorg-3", 
    "We arrived at the facility today. It's worse than I imagined.\n\n\
The official story is it's sealed for safety. Contamination from a failed experiment. \
But the seal isn't to keep danger in. It's to keep witnesses out.\n\n\
The researchers I'm supposed to be protecting are nervous. They keep looking at me like \
they're not sure if I'm here to help them or kill them.\n\n\
Maybe they're right to be afraid. I don't know who I work for anymore.\n\n\
My partner won't leave the Ghost Pokemon's side. They keep going to the same spot - \
near the Red Lake. There's something there they want me to see.")
end

def pbDiary_Act3_TheDiscovery
  pbAddDiaryEntry("Week 10 - The Bodies", 
    "Found them today. The test subjects.\n\n\
Preserved in stasis. Dozens of them. Hundreds maybe. The logs say they were 'volunteers' \
for extraction experiments. The logs are lying.\n\n\
Their faces... some of them are screaming. Frozen mid-scream. Like they're still conscious in there. \
Still aware. Still suffering.\n\n\
The Red Lake isn't water. It's concentrated soul essence. You can see it moving. Writhing. \
Like it's trying to remember what it used to be.\n\n\
I threw up. Professional mercenary. Veteran UCWD marine. And I threw up like a rookie.")
end

def pbDiary_Act3_TheMemory
  pbAddDiaryEntry("Week 10 - I Was Here", 
    "The scientists showed me the records. UCWD deployment logs. Disaster relief team. \
Belorg-3 aftermath cleanup.\n\n\
My name is on the list.\n\n\
I was here. Right after it happened. I SAW this. I saw the bodies, the Red Lake, the contamination. \
I saw Pokemon emerging from the essence - born from fragmented souls, tortured and wrong.\n\n\
And then I forgot. They made me forget.\n\n\
'Soul therapy' they called it. To help with the trauma. But it wasn't therapy. \
They suppressed the memory. Buried it under layers of artificial calm. And then they put me on injections.\n\n\
How much of me is real? How much is product?\n\n\
The scientist said: 'The you that felt horror - that tried to save people - that's real. \
The you that forgot - that's what they did to you.'\n\n\
I don't know if I believe him. But my partner does. They've been here the whole time, \
trying to remind me who I was.")
end

def pbDiary_Act3_TheChoice
  pbAddDiaryEntry("Week 10 - Orders", 
    "UCWD called. They know what we found. They want the scientists eliminated. \
'Security breach. Loose ends. For the greater good.'\n\n\
I'm standing here with my weapon, looking at these people who just gave me back my memory, \
and I'm supposed to kill them.\n\n\
It would be easy. I'm good at this. It's what I was trained for.\n\n\
But my partner is standing between me and them. Not aggressively. Just... there. \
Looking at me with those eyes that have seen every version of me.\n\n\
The Ghost Pokemon is standing with them. Two Pokemon who survived horrors I helped create, \
telling me this is where it stops.\n\n\
I'm not pulling the trigger.\n\n\
I guess that makes me a traitor now.")
end

#===============================================================================
# ACT 4: THE REBEL
#===============================================================================

def pbDiary_Act4_FirstResistanceOp
  pbAddDiaryEntry("Month 3 - Sabotage", 
    "First operation with the resistance. We hit an Asterisk supply convoy. \
Same kind of cargo I used to deliver. Except this time, we're stopping it from reaching people.\n\n\
The route was familiar. I've run it a dozen times. Knew every checkpoint, every patrol pattern. \
Muscle memory from my courier days.\n\n\
We saved forty people from extraction. Forty souls that won't end up in bottles.\n\n\
One of them looked at me and said 'thank you.' I didn't know what to say. \
What do you say to someone when you've spent months damning people just like them?\n\n\
Is my guilt real? Or is it just the injections wearing off?")
end

def pbDiary_Act4_RescueMission
  pbAddDiaryEntry("Month 3 - The Victims", 
    "We raided an extraction facility today. Got there in time to stop the process for most of them.\n\n\
But some had already been harvested. We found them in the recovery ward - alive but hollow. \
Moving, breathing, but the light in their eyes was gone. Replaced with something manufactured.\n\n\
I used to deliver the compounds that do this. I used to think I was helping them cope with trauma.\n\n\
One of the victims was from Vettle. My home planet. She recognized my accent. \
Asked if I knew her brother - a miner who died in a collapse.\n\n\
I didn't know him. But I probably transported his essence after they harvested him.\n\n\
She didn't blame me when I told her what I used to do. That somehow makes it worse.")
end

def pbDiary_Act4_SleepyHollowInfiltration
  pbAddDiaryEntry("Month 4 - Black Market", 
    "Infiltrated a Sleepy Hollow operation today. They're selling artificial spiritual experiences. \
'Faith in a bottle' they call it.\n\n\
It's soul essence. Processed and packaged as religious enlightenment. \
People pay thousands of credits to feel what they think is divine connection.\n\n\
What they're actually feeling is someone else's dying moments. Someone else's last prayers. \
Someone else's soul, commodified and sold.\n\n\
The other operatives wanted to burn the whole place down. I convinced them to just take the evidence. \
We need people to see this. To understand what's being done.\n\n\
But part of me wanted to burn it too.")
end

def pbDiary_Act4_PokemonLabs
  pbAddDiaryEntry("Month 4 - The Pokemon Labs", 
    "Found Asterisk's Pokemon experimentation facility. I thought Belorg-3 was the worst thing I'd see.\n\n\
They're trying to extract soul essence from Pokemon. Testing whether Pokemon souls are 'compatible' \
with human consciousness. Trying to create hybrid entities.\n\n\
The survivors... they're not Pokemon anymore. Not fully. And not human either. Just... broken.\n\n\
My partner and the Ghost Pokemon found their holding cells. Started releasing them. \
The resistance team helped, but the Pokemon were too traumatized to run. \
They just huddled together, waiting for the next experiment.\n\n\
We got them out. All of them. Even the ones who were too far gone.\n\n\
My partner hasn't left their side since. Like they're trying to absorb all that pain, \
tell them it's going to be okay.\n\n\
I don't know if it will be. But at least they're free.")
end

def pbDiary_Act4_IdentityCrisis
  pbAddDiaryEntry("Month 5 - Who Am I?", 
    "Met another ex-UCWD soldier today. Same story as mine - deployed to disaster sites, \
traumatized, 'treated' with soul therapy, put on injections, forgot everything.\n\n\
She asked me: 'Do you remember what flavor was your favorite food before the treatment?'\n\n\
I couldn't answer. I don't remember. I eat what's efficient. What keeps me operational.\n\n\
She said: 'I loved chocolate. Dark chocolate with sea salt. My wife used to make it for me. \
I forgot that for three years. The injections made me forget joy.'\n\n\
Is that what happened to me? Did I forget joy? Did I forget... myself?\n\n\
My partner brought me something today. A fruit from Seventeen - from those farmers I tried to rob. \
It was sweet. Really sweet. And for a moment, I felt something beyond efficiency.\n\n\
Maybe that's the proof. Not that I remember who I was. But that I can still feel.")
end

def pbDiary_Act4_VettleConnection
  pbAddDiaryEntry("Month 6 - Home", 
    "They sent me back to Vettle. Resistance needs intel on Asterisk operations there.\n\n\
I didn't want to come back. Haven't been home since I joined UCWD. Thought there was nothing here for me.\n\n\
I was wrong.\n\n\
Asterisk has major operations here. The mining accidents that happen so frequently? \
Not all accidents. They're creating 'volunteers' - people so desperate they'll sign anything.\n\n\
Found records going back years. Names I recognize. People I grew up with. \
Miners who 'died' in collapses. Except they didn't die. They were harvested.\n\n\
My childhood neighbor. The woman who taught me to handle Pokemon. The foreman who gave me my first job.\n\n\
All of them, reduced to commodities.\n\n\
This isn't just another mission anymore. This is personal.")
end

def pbDiary_Act4_RitedaProject
  pbAddDiaryEntry("Month 6 - The Fruit", 
    "Intelligence briefing today. Asterisk's endgame: artificial Kiwilaba fruit.\n\n\
The original fruit could manipulate reality. Asterisk wants to synthesize it. \
Create it in a lab. Control it. Use it.\n\n\
CEO Rio Riteda is leading the project personally. The briefing said he's been undergoing \
extraction repeatedly - practicing in the Nothing Well. Learning to see the strings. \
Learning to pull them.\n\n\
If he succeeds, he won't just control people through soul injections. He'll control reality itself. \
Rewrite history. Make his rule inevitable. Erase resistance before it begins.\n\n\
The resistance is planning a major operation. They need someone who understands Asterisk's security. \
Someone who's seen their facilities. Someone expendable enough to risk.\n\n\
They're looking at me.\n\n\
My partner pressed their head against my hand when I volunteered. Like they knew what I was choosing.")
end

def pbDiary_Act4_MotherRevelation
  pbAddDiaryEntry("Month 7 - Mother", 
    "Found something in the Vettle records. A name I knew I'd see eventually but hoped I wouldn't.\n\n\
Dr. Kiera Vane. Research specialist. Asterisk subsidiary on Vettle. Recruited six years ago.\n\n\
That's my mother.\n\n\
She's alive. She's been alive this whole time. Working for them.\n\n\
The resistance intel says she's involved in the extraction refinement process. \
Making it more efficient. Less waste. Better product.\n\n\
I don't know if she knows what I've become. If she knows I was on the other side. \
If she knows I'm on this side now.\n\n\
I don't know if I can face her.\n\n\
But the operation requires infiltrating the central facility. And she has access.\n\n\
I have to see her. Even if it destroys me.")
end

#===============================================================================
# ACT 5: THE NOTHING WELL
#===============================================================================

def pbDiary_Act5_ThePlan
  pbAddDiaryEntry("Month 7 - Infiltration Plan", 
    "The plan is insane. Pose as a volunteer extraction subject. Let them take me to central processing. \
Experience extraction firsthand. Then sabotage from inside.\n\n\
I'll be conscious during extraction. I'll see the Nothing Well. Navigate it. Find Rio Riteda's lab.\n\n\
The cost: I might not come back. Not fully. The Nothing Well breaks people. \
And if Rio catches me there, he can manipulate my strings. Make me into anything he wants.\n\n\
My partner can't follow me into the Well. They'll guard my body. Keep me anchored to reality. \
But in the void, I'll be alone.\n\n\
The Ghost Pokemon brought me something today. A small stone from the Red Lake. Contaminated. Wrong. \
But also proof that something can survive the Nothing Well. Something can come back changed but whole.\n\n\
I'm going in tomorrow.")
end

def pbDiary_Act5_ExtractionBegins
  pbAddDiaryEntry("Month 7 - The Separation", 
    "They're preparing me for extraction. Cold metal table. Needles full of KL13. \
Researchers marking points on my body where the strings connect.\n\n\
My partner is in a holding area. I can hear them crying. They know what's happening. \
They know I might not come back as myself.\n\n\
The technician just asked if I have any last words. I told him to go to hell.\n\n\
He laughed. Said everyone says something like that. Right before they see the truth.\n\n\
The injection burns. It burns like fire and ice at once. Like my soul is being peeled away from my body.\n\n\
I can see the strings now. They're everywhere. Connected to everything. To everyone.\n\n\
One of them is pulling. Pulling me away.\n\n\
I'm falling.\n\n\
Into nothing.")
end

def pbDiary_Act5_InTheVoid
  pbAddDiaryEntry("??? - The Nothing Well", 
    "There's no time here. No space. Just void and strings and consciousness.\n\n\
I can see everything. Every connection. Every soul. Every fragment.\n\n\
I can see the pieces of me that were taken. Suppressed. Rewritten. \
The memory of Belorg-3. The capacity for joy. The ability to trust.\n\n\
I can see the pieces that were added. Manufactured calm. Artificial purpose. Engineered guilt.\n\n\
And underneath it all, I can see... me. The core that they couldn't touch. \
The part that chose to stop. That chose to save people. That chose resistance.\n\n\
My partner's string is still connected to me. Glowing brighter than anything else in the void. \
They're calling me back. Reminding me I'm not just strings and essence.\n\n\
But there's something else here. Something vast. Looking at me.\n\n\
The One True Being.\n\n\
And it's offering me a choice.")
end

def pbDiary_Act5_TheTemptation
  pbAddDiaryEntry("??? - Rio's Offer", 
    "Rio Riteda found me in the void. Or maybe I found him. It's hard to tell here.\n\n\
He can manipulate strings like he's conducting an orchestra. Every movement precise. Perfect. \
He's been practicing for years. Extracting himself repeatedly. Building immunity to the trauma.\n\n\
He showed me things. Visions of what could be:\n\n\
A world where no one suffers extraction. Because everyone willingly gives their essence for the greater good.\n\
A reality where the Collapse never happened. Where Marseilles still stands. Where millions live.\n\
A timeline where I never became a mercenary. Never killed. Never forgot.\n\n\
'Join me,' he said. 'We'll remake everything. Restore every harvested soul. \
Bring back everyone who was lost. Including yourself.'\n\n\
'You could have your mother back. Not as she is now, but as she was. Before Asterisk. \
Before desperation made her compromise.'\n\n\
'You could fix it all. The violence. The trauma. The guilt. Just... reach out and pull the right strings.'\n\n\
For a moment, I wanted to. The power to undo every mistake. Every victim. Every crime.\n\n\
But then I remembered the farmers on Seventeen. Their Pokemon weren't restored through string manipulation. \
They were healed through connection. Through choice. Through authentic growth.\n\n\
This isn't healing. It's control wearing a benevolent mask.")
end

def pbDiary_Act5_TheRejection
  pbAddDiaryEntry("??? - My Choice", 
    "I told Rio no.\n\n\
Not because I don't want to fix things. Not because the power wouldn't be useful. \
But because this isn't the answer.\n\n\
He showed me what he'd do with the artificial Kiwilaba fruit. A world of perfect order. \
No crime. No suffering. No resistance. Because everyone would be too controlled to resist.\n\n\
'They'll be happy,' he said. 'I'll make them happy. Isn't that what matters?'\n\n\
But manufactured happiness isn't happiness. Enforced order isn't peace. \
A world without choice is a world without meaning.\n\n\
I've lived under manufactured emotions. It's a different kind of hell.\n\n\
My partner's string pulsed brighter. Like they were agreeing. Pulling harder. \
Reminding me that real connection doesn't come from manipulation.\n\n\
Rio's face twisted. 'Then you'll stay here. In the void. I'll cut your strings. \
Scatter your essence across the Well. You'll never find your way back.'\n\n\
But I can still see my partner's string. And the Ghost Pokemon's string is there too. \
And the strings of everyone I've saved. Everyone I've fought with.\n\n\
I'm not alone in the void after all.\n\n\
I'm following them home.")
end

def pbDiary_Act5_Return
  pbAddDiaryEntry("Month 7 - Awakening", 
    "I'm back. In my body. In reality.\n\n\
My partner is pressed against me, crying. The Ghost Pokemon is there too. \
And half the resistance team, apparently standing guard for the three days I was under.\n\n\
Three days. It felt like years in the void.\n\n\
But I can still see them. The strings. Faint, like afterimages. \
I can see who's connected to what. Who's been compromised. Who's intact.\n\n\
The technician who injected me is backed into a corner. My team wants to know if he's a threat. \
I can see his strings - controlled by Asterisk. Reporting our position right now.\n\n\
I tell them. They secure him.\n\n\
We have to move. Rio knows we're here. Knows we're coming.\n\n\
The final confrontation is starting. And I can see exactly what we're up against.")
end

#===============================================================================
# ACT 6: THE REVOLUTION
#===============================================================================

def pbDiary_Act6_Preparation
  pbAddDiaryEntry("Month 8 - Before the Storm", 
    "Multi-team operation launching in six hours. This is it. Everything we've fought for comes down to this.\n\n\
Team Alpha hits the extraction facilities. Shut them down. Free everyone we can.\n\
Team Beta targets the distribution network. Cut off the supply of processed essence.\n\
Team Delta - my team - goes straight for Rio Riteda at Asterisk headquarters.\n\n\
Intelligence says he's completed the artificial Kiwilaba fruit. He's already started mass string manipulation. \
People across the solar system are losing themselves. Becoming puppets.\n\n\
But Pokemon are resisting. Their souls are too strong. Too authentic. \
They're the only ones who can break through the manipulation.\n\n\
My partner hasn't left my side. Neither has the Ghost Pokemon. Or the Grass-type from Seventeen. \
Or the others we've gathered. They know what's at stake.\n\n\
If we fail, Rio rewrites reality. Resistance becomes impossible. Because resistance will never have existed.\n\n\
If we succeed... I don't know what happens. Maybe things get better. Maybe they don't. \
But at least they'll be real.\n\n\
My team is waiting. It's time.")
end

def pbDiary_Act6_AssaultBegins
  pbAddDiaryEntry("Month 8 - The Assault", 
    "We're inside Asterisk headquarters. Fighting our way to Rio's lab.\n\n\
UCWD forces are everywhere. Some are compromised - controlled by strings. \
But others are just following orders. They don't know what they're protecting.\n\n\
I keep trying to tell them. Show them what's happening. Some listen. Some join us. \
Others... they're too far gone. Injections and string manipulation combined.\n\n\
My partner is identifying the controlled ones before I even see them. \
They can sense the corrupted strings. The artificial connections.\n\n\
We lost three people getting to the inner sanctum. Asterisk experiments stopped another four. \
Corrupted humans and Pokemon, twisted by failed extraction procedures.\n\n\
One of them was from Vettle. I recognized his face from the records. A miner I knew as a kid.\n\n\
I'm sorry. I'm so sorry.\n\n\
But we can't stop. If we stop, everyone becomes like him.")
end

def pbDiary_Act6_StringPuppets
  pbAddDiaryEntry("Month 8 - Betrayal", 
    "Rio turned our own people against us. String manipulation in real time.\n\n\
Four resistance members just attacked us. People I've fought beside for months. \
I can see their strings being pulled. See Rio's consciousness controlling them.\n\n\
My partner and the Psychic-type we found are countering it. Breaking the connections. \
But it's exhausting them. Every severed string is a battle.\n\n\
Rio's voice is everywhere: 'You can't win. I'm rewriting reality as we speak. \
In ten minutes, you'll forget you ever resisted. In twenty, you'll worship me. \
In thirty, this conversation will never have happened.'\n\n\
But I can see his strings too. They're stretched thin. Controlling this many people simultaneously \
is taking everything he has. He's vulnerable.\n\n\
We just have to reach him before he finishes the fruit's integration.")
end

def pbDiary_Act6_FinalConfrontation
  pbAddDiaryEntry("Month 8 - Rio Riteda", 
    "Found him. In a chamber at the heart of the facility. Surrounded by the Nothing Well's essence. \
The artificial Kiwilaba fruit floating in a containment field.\n\n\
He's already consumed part of it. I can see reality bending around him. \
Strings appearing and disappearing. Timelines branching and collapsing.\n\n\
He smiled when he saw me. 'You came back. Good. I want you to see what true power looks like.'\n\n\
He pulled my strings. I felt myself moving against my will. Attacking my own team.\n\n\
But my partner intervened. They severed the connection. It hurt - like part of my soul was torn - \
but I was free again.\n\n\
The battle is chaos. Reality itself is a weapon. My Pokemon are the only things keeping us anchored. \
Their authentic souls can't be fully manipulated. Can't be rewritten.\n\n\
Rio keeps showing me visions. My mother, restored. My victims, brought back. My sins, erased.\n\n\
'Just stop fighting,' he says. 'Let me fix everything.'\n\n\
But I've seen what his 'fixed' reality looks like. Everyone smiling. Everyone obedient. Everyone hollow.\n\n\
I'd rather die as myself than live as his puppet.")
end

#===============================================================================
# MULTIPLE ENDINGS - Add the appropriate one based on player choices
#===============================================================================

def pbDiary_Ending_Victory_HighIntegrity
  pbAddDiaryEntry("Month 9 - After", 
    "Rio Riteda is dead. The artificial fruit destroyed. Asterisk's leadership scattered.\n\n\
It wasn't clean. We lost too many people. The facility collapsed. Half my team didn't make it out.\n\n\
But the extraction facilities are shut down. The victims are being treated. \
The resistance is working with the remnants of UCWD to rebuild something better.\n\n\
My mother survived. She was under string control for three years. Didn't have a choice in what she did. \
We're... talking. It's difficult. But we're trying.\n\n\
I can still see the strings sometimes. Faint afterimages from my time in the Nothing Well. \
The Psychic-type helps me understand what I'm seeing. How to help people whose strings were damaged.\n\n\
My partner is sleeping next to me as I write this. The Ghost Pokemon too. \
They've earned their rest. We all have.\n\n\
I'm not fixed. The injections did permanent damage. The memory suppression left scars. \
But I'm healing. Slowly. Authentically.\n\n\
Maybe that's all redemption really is. Not erasing what you've done. But choosing, every day, to be better.")
end

def pbDiary_Ending_Victory_LowIntegrity
  pbAddDiaryEntry("Month 9 - After", 
    "We won. If you can call this winning.\n\n\
Rio is dead. The fruit destroyed. But so much else is gone too.\n\n\
Half the resistance. Most of my team. Three of my Pokemon partners.\n\n\
My mother didn't survive the facility collapse. I never got to ask her why. Why she worked for them. \
If she had a choice. If she ever thought about me.\n\n\
I can still see the strings. But I don't trust what I'm seeing anymore. \
The time in the Nothing Well damaged something in me. I confuse real connections with artificial ones. \
Push people away because I can't tell if their emotions are genuine.\n\n\
My partner is still here. They're the only constant. The only proof that anything I feel is real.\n\n\
UCWD wants me to help rebuild. Use my string-sight to identify corrupted individuals. \
But I'm not sure I'm qualified to judge what's real anymore.\n\n\
We stopped Rio from rewriting reality. But I can't shake the feeling that I'm living in a damaged timeline. \
One where I made all the wrong choices and got a hollow victory.\n\n\
Maybe I'm just broken. Maybe this is what winning feels like when you're not whole.")
end

def pbDiary_Ending_Dark_PlayerJoinsRio
  pbAddDiaryEntry("??? - Beyond", 
    "I took his hand. Accepted the fruit. Consumed the power.\n\n\
The Nothing Well opened fully. I can see every string now. Every connection. Every possibility.\n\n\
Rio was right. Pain manipulation is control. And with the fruit, I can eliminate pain entirely. \
Make everyone perfectly content. Perfectly obedient. Perfectly... empty.\n\n\
My partner won't look at me anymore. Neither will the others. They know what I've become.\n\n\
But they'll forget soon. Everyone will. I'm rewriting it all.\n\n\
In the new timeline, Asterisk never existed. The Collapse never happened. Everyone I've killed is alive.\n\n\
But they're not free. Because free people suffer. Free people resist. Free people make mistakes.\n\n\
I'm fixing that. Making a world without mistakes. Without suffering. Without choice.\n\n\
Rio is laughing. He says I've exceeded him. That I understand the vision better than he ever did.\n\n\
But I can still see one string I can't manipulate. My partner's. \
It keeps trying to connect to me. To remind me of who I was.\n\n\
I should sever it. Make them forget too. But I can't bring myself to cut that last thread.\n\n\
Maybe that's my weakness. Or maybe it's the last proof I'm still human.\n\n\
Either way, reality is mine now. And I'm going to make it perfect.\n\n\
Whether anyone wants it or not.")
end

def pbDiary_Ending_Sacrifice
  pbAddDiaryEntry("Month 8 - Final Entry", 
    "This is probably my last entry. I'm writing it while my partner stands guard.\n\n\
Rio won't stop. The fruit is too integrated. He can regenerate from string manipulation. \
Every time we hurt him, he just rewrites himself as unharmed.\n\n\
But there's a way. The Ghost Pokemon showed me. In the Nothing Well, they found the instructions. \
The Finality Scrolls that The Finality Incorporation was studying.\n\n\
If someone with string-sight enters the Nothing Well while holding the fruit, \
they can unmake it. Reverse the instructions. Delete the code.\n\n\
But they can't come back. The Nothing Well consumes anyone who tries to manipulate it that deeply.\n\n\
So I'm going in. One more time. But this time, I'm not coming back.\n\n\
My team argued. Said we'd find another way. But I can see the strings. \
I can see reality fraying. Every moment Rio lives, more timelines collapse. More people cease to exist.\n\n\
My partner knows what I'm doing. They pressed their head against my hand one last time. \
Like they did that first day on Oasis. When I was just a courier who didn't ask questions.\n\n\
I asked them to go with the team. To find someone else. To forget me.\n\n\
They're still here. Stubborn Pokemon. Loyal to the end.\n\n\
When this is over, give them to someone good. Someone who'll remember what it means to choose freely. \
Someone who'll treat them like more than a tool.\n\n\
Tell them I'm sorry I couldn't be that person sooner.\n\n\
Tell them they saved me. Even if I couldn't save myself.\n\n\
It's time. The Ghost Pokemon is ready. They're coming with me. \
Back to the Nothing Well. Back to where they were broken.\n\n\
This time, we're breaking the thing that broke us.\n\n\
Arya Vane, signing off.")
end

def pbDiary_Ending_Hope
  pbAddDiaryEntry("Month 10 - Rebuilding", 
    "Two months since the battle. Since Rio fell. Since we destroyed the artificial fruit.\n\n\
The solar system is chaos. UCWD is fracturing. Asterisk's subsidiaries are fighting over the remains. \
The Finality Incorporation went underground after we exposed their research.\n\n\
But there's hope too.\n\n\
The extraction facilities are being converted to treatment centers. \
Researchers are working on ways to help people whose souls were fragmented.\n\n\
The farmers on Seventeen are teaching their methods to other colonies. \
Pokemon-assisted agriculture that heals the land and the people working it.\n\n\
My mother is helping coordinate the medical response. Three years of forced research for Asterisk \
gave her knowledge no one else has. She's using it to undo the damage.\n\n\
We're talking more now. About Vettle. About why she made the choices she did. \
About how we both became people we didn't want to be.\n\n\
I still see the strings sometimes. But I'm learning to live with it. \
Use it to help people instead of harm them. Identify those who need healing. \
Find the connections that are genuine.\n\n\
My partner is healthier than I've ever seen them. The Ghost Pokemon too. \
They're surrounded by other Pokemon now - the ones we rescued from the labs. \
Healing together. Teaching each other what authentic connection looks like.\n\n\
I'm not fixed. I don't know if I'll ever be fully 'fixed.' \
The injections changed me permanently. The memory suppression left gaps I can't fill.\n\n\
But I'm choosing who I want to be. Every day. Not because someone manipulated my strings. \
Not because chemicals forced artificial emotions. But because I decided this is who I am.\n\n\
A person who made terrible choices. Who was broken and used and manipulated. \
But who chose, in the end, to stop. To fight back. To try.\n\n\
Maybe that's enough.\n\n\
My partner just brought me a fruit from Seventeen. Still trying to feed me. Still believing I'm worth saving.\n\n\
Yeah. Maybe that's enough.")
end
