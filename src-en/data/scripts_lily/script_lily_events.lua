local vter = mods.multiverse.vter
local string_starts = mods.multiverse.string_starts
local screen_fade = mods.multiverse.screen_fade
local screen_shake = mods.multiverse.screen_shake
local on_load_game = mods.multiverse.on_load_game
local INT_MAX = 2147483647



mods.lilybeams.lilySylvanHater = {}
mods.lilybeams.lilySylvanHaterNoSur = {}


mods.lilybeams.lilySylvanHater = {}
mods.lilybeams.lilySylvanHaterNoSur = {}
mods.lilybeams.lilySylvanHater["SYLVAN_CASHGRAB"] = true
mods.lilybeams.lilySylvanHater["SYLVAN_REBEL"] = true
mods.lilybeams.lilySylvanHater["SYLVAN_JOKE"] = true
mods.lilybeams.lilySylvanHater["SYLVAN_HARDSCIFI"] = true
mods.lilybeams.lilySylvanHater["SYLVAN_SANS"] = true

mods.lilybeams.lilySylvanHaterNoSur["NEXUS_PORTAL_SURRENDER"] = true
mods.lilybeams.lilySylvanHaterNoSur["SYLVAN_REBEL_SURRENDER"] = true

mods.lilybeams.lilyFightQuotes = { "Prepare to get obliterated, pest!--", "Are you ready - to meet you maker?--",
"EXTERMINATION PROTOCOL: TARGET ACQUIRED", "Die, in Her name!--" }
mods.lilybeams.lilyNoSurQuotes = { "No mercy for insects!--", "Get Crushed!--", "Begging won't help--",
"Any last words?" }

mods.lilybeams.lilyVisionQuotes = {

	"A vessel as black as night approaches, and without words and starts charging it's weapons. But soon realizing who you are, they quickly stop.",
	"\"And so this is the Renegade that set the eternal reign of chaos in motion?\" How helpful, but don't even try to undo the inevietable. Maybe there's a place for you still.",
	"An alien vessel, another of Her minions, approaches. There is seemingly no end to these legions of darkness.",
	"You think you might be hallucinating at first, but a black vessel begins to take form in front of you. In the darkness of space, you narrowly avoid colliding with it.",

}

local function LilyForceFight(event)
    local invalid = Hyperspace.Event:CreateEvent("OPTION_INVALID", Hyperspace.App.world.starMap.worldLevel, true);
    local fight = Hyperspace.Event:CreateEvent("LILY_MAD_FIGHT", Hyperspace.App.world.starMap.worldLevel, true);
    local Choices = event:GetChoices()
    for choice in vter(Choices) do
        choice.event = invalid
    end
    local req = Hyperspace.ChoiceReq()
    req.object = "LILY_PATRONAGE"
    req.min_level = 1
    req.max_level = 999
    req.max_group = 0
    req.blue = true
    event:AddChoice(fight, mods.lilybeams.lilyFightQuotes[math.random(#mods.lilybeams.lilyFightQuotes)], req, false)
end

local function LilyForceNoSur(event)
    local invalid = Hyperspace.Event:CreateEvent("OPTION_INVALID", Hyperspace.App.world.starMap.worldLevel, true);
    local fight = Hyperspace.Event:CreateEvent("LILY_MAD_SURRENDER", Hyperspace.App.world.starMap.worldLevel, true);
    local Choices = event:GetChoices()
    for choice in vter(Choices) do
        choice.event = invalid
    end
    local req = Hyperspace.ChoiceReq()
    req.object = "LILY_PATRONAGE"
    req.min_level = 1
    req.max_level = 999
    req.max_group = 0
    req.blue = true
    event:AddChoice(fight, mods.lilybeams.lilyNoSurQuotes[math.random(#mods.lilybeams.lilyNoSurQuotes)], req, false)
end

mods.lilybeams.LilyForceFight = LilyForceFight
mods.lilybeams.LilyForceNoSur = LilyForceNoSur

script.on_internal_event(Defines.InternalEvents.PRE_CREATE_CHOICEBOX, function(event)
    if event.eventName == "LILY_EMPORIUM_GLITCH" then
        Hyperspace.playerVariables.lily_backdoor = 1
    end
    --print(event.eventName)
    local shipManager = Hyperspace.ships.player

    -- If player visited Lily and made a deal
    if shipManager and shipManager:HasAugmentation("LILY_PATRONAGE") > 0 then

    
        if event.eventName == "TRANSPORT_CAPTURE_STARGROVE" then
            local replace = Hyperspace.Event:CreateEvent("TRANSPORT_CAPTURE_STARGROVE_LILY",
                Hyperspace.App.world.starMap.worldLevel, true);
            local req = Hyperspace.ChoiceReq()
            req.object = "LILY_PATRONAGE"
            req.min_level = 1
            req.max_level = 999
            req.max_group = 0
            req.blue = false
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = replace
                choice.textv = "Continue..."
            end
        end











        --Nexus stuff ahead
        if mods.lilybeams.lilySylvanHater[event.eventName] ~= nil then
            LilyForceFight(event)
        end
        if mods.lilybeams.lilySylvanHaterNoSur[event.eventName] ~= nil then
            LilyForceNoSur(event)
        end
        local invalid = Hyperspace.Event:CreateEvent("OPTION_INVALID", Hyperspace.App.world.starMap.worldLevel, true);

        -- G-Van
        if event.eventName == "NEXUS_GUARD_SURRENDER" then
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i == 1 then
                    choice.event = invalid
                end
                if i == 2 then
                    choice.text.data = mods.lilybeams.lilyNoSurQuotes[math.random(#mods.lilybeams.lilyNoSurQuotes)]
                end
                i = i + 1
            end
        end

        -- Narrator
        if event.eventName == "SYLVAN_NARRATOR_AGAIN" then
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i == 1 then 
                    choice.event = invalid
                end
                i = i + 1
            end
        end

        -- Dylan
        if event.eventName == "DYLAN" then
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i <= 2 then 
                    choice.event = invalid
                end
                if i == 3 then
                    choice.text.data = mods.lilybeams.lilyFightQuotes[math.random(#mods.lilybeams.lilyFightQuotes)]
                end
                i = i + 1
            end
        end

        --[[ Capitalist
        if event.eventName == "SYLVAN_CASHGRAB" then
            local fight = Hyperspace.Event:CreateEvent("LILY_MAD_FIGHT", Hyperspace.App.world.starMap.worldLevel, true,
                Hyperspace.Global.currentSeed);
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = invalid
            end
            local req = Hyperspace.ChoiceReq()
            req.object = "LILY_PATRONAGE"
            req.min_level = 1
            req.max_level = 999
            req.max_group = 0
            req.blue = true
            event:AddChoice(fight, mods.lilybeams.lilyFightQuotes[math.random(#mods.lilybeams.lilyFightQuotes)], req, false)
        end]]--

        -- Everything
        if event.eventName == "SYLVAN_EVERYTHING" then
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i == 1 then
                    choice.event = invalid
                end
                i = i + 1
            end
        end
        

        -- Surrender
        if event.eventName == "SYLVAN_PRIME_SURRENDER_REAL" then
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i == 1 then
                    choice.event = invalid
                    choice.text.data = "You may be willing to spare Prime. But I am certainly not--"
                end
                i = i + 1
            end
        end
        
        -- Gnome
        if event.eventName == "SYLVAN_PRIME_SURRENDER_GNOME_2" then
            local gnomealt = Hyperspace.Event:CreateEvent("NEXUS_HER_REVEAL_FADE_LILY",
            Hyperspace.App.world.starMap.worldLevel, true);
            local Choices = event:GetChoices()
            local i = 1
            for choice in vter(Choices) do
                if i == 1 then
                    choice.event = gnomealt
                end
                i = i + 1
            end
        end
        
        -- Her realm
        if event.eventName == "REALM_MADNESS_START" then
            event.text.data = "You've arrived in some kind of swirling hellscape, mired by a blurry haze of what seems to be taunting barely human faces flying through the abyss. Despite the nighmarishness of the surrounding space, you feel ...oddly content and at peace.\n\n\"Ah, my home at last--\" - says Lily.\n\"Shame that I haven't been there in eons; Charming, isn't?--\"\n\n\"Don't worry, I'll make sure you are in no danger here--\""
            local replace = Hyperspace.Event:CreateEvent("REALM_MADNESS_START_LILY",
                Hyperspace.App.world.starMap.worldLevel, true);
            local req = Hyperspace.ChoiceReq()
            req.object = "LILY_PATRONAGE"
            req.min_level = 1
            req.max_level = 999
            req.max_group = 0
            req.blue = true
            --event:AddChoice(replace, "Continue...", req, false)
            
        end

        -- Vision
        if event.eventName == "VISION_ENCOUNTER" then
            event.text.data = mods.lilybeams.lilyVisionQuotes[math.random(#mods.lilybeams.lilyVisionQuotes)]
           
            local replace1 = Hyperspace.Event:CreateEvent("VISION_ENCOUNTER_LILY",
                Hyperspace.App.world.starMap.worldLevel, true);
            local req = Hyperspace.ChoiceReq()
            req.object = "LILY_PATRONAGE"
            req.min_level = 1
            req.max_level = 999
            req.max_group = 0
            req.blue = true
            --event:AddChoice(replace1, "Continue...", req, false)
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = replace1
            end
        end

        -- Her
        if event.eventName == "HER_FIGHT" then
            event.text.data =
            "You've finally made it to the location of Her. The entire space around is nothing but darkness, with every star having been pulled out of the night sky and consumed by some ancient evil. This is it. You're about to meet with perhaps the most powerful and evil entity known to exist in the Multiverse... again."
            local replace2 = Hyperspace.Event:CreateEvent("HER_NOFIGHT_LILY",
                Hyperspace.App.world.starMap.worldLevel, true);
            local req = Hyperspace.ChoiceReq()
            req.object = "LILY_PATRONAGE"
            req.min_level = 1
            req.max_level = 999
            req.max_group = 0
            req.blue = true
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = replace2
            end
            --event:AddChoice(replace, "Continue...", req, false)
        end
    end

    -- If player visited Lily but did NOT make a deal
    if (shipManager and shipManager:HasAugmentation("LILY_PATRONAGE") <= 0) and (Hyperspace.playerVariables.lily_backdoor > 0) then
        -- Prime gets sniped
        if event.eventName == "SHE_IS_DEFEATED" then
            event.text.data =
            "As your hull is reduced to critical levels, you notice Prime himself has dismounted from his rings, and is now holding them above his head. \"You're right, it wasss my missstake to keep you around. Good thing I didn't make the missstake of making it perma-\" Prime doesn't get to finish his words as a beam striking from an unknown direction vaporizes him instantly."
            Hyperspace.Sounds:PlaySoundMix("focus_strong", -1, false)
            local replace3 = Hyperspace.Event:CreateEvent("SHE_IS_DEFEATED_NOT",
                Hyperspace.App.world.starMap.worldLevel, true);
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = replace3
            end
        end

        -- Her
        if event.eventName == "HER_FIGHT" then
            event.text.data = event.text.data .. "\n\nHowever, even there, you receive a message:\n\"Hey, sorry for the delay but I'll be here soon!--\nI've got gome gifts that should SERIOUSLY turn the tide of battle, just wait--\nJust need to get a proper object to calibrate my jump drive at--\""
        end

        if event.eventName == "HER_SUPPORT" then
            local replace4 = Hyperspace.Event:CreateEvent("LILY_NUKE_INCOMING",
                Hyperspace.App.world.starMap.worldLevel, true);
            local Choices = event:GetChoices()
            for choice in vter(Choices) do
                choice.event = replace4
            end
        end


    end

end)

script.on_game_event("NEXUS_HER_REVEAL_FADE_LILY", false, function()
    screen_shake(3.7) --Here we shake the screen for 3.7 seconds, and start a fade to black that will mask the transition before fading out for one second. This is just long enough for the triggered event to happen, so we can easily tell that our effects are synchronized just by looking at the timer.
    screen_fade(Graphics.GL_Color(0, 0, 0, 1), 2, 1.7, 1)
end)

script.on_game_event("NEXUS_ENDING_NOTGOOD_FADE", false, function()
    screen_fade(Graphics.GL_Color(0.75, 0, 0, 1)) --Here we start a fade to red that will last 3 seconds, such that the transition at 2 seconds is masked
end)

script.on_game_event("LILY_NUKE_PORTAL_FADE", false, function()
    screen_shake(6)
    screen_fade(Graphics.GL_Color(1, 1, 1, 1), 1, 5, 1) --Here we shake the screen for 6 seconds, and start a fade to white that will mask the transition before fading out for one second.
end)

script.on_game_event("HER_NOFIGHT_LILY", false, function()
---@diagnostic disable-next-line: lowercase-global
    herVirus = true
---@diagnostic disable-next-line: lowercase-global
    titleSet = false
    Hyperspace.setWindowTitle("FTL: Multiverse :)")
end)
