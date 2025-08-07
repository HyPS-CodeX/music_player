local current_music = {}
local player_volume = {}
local player_track_index = {}

local tracks = {
    "track1",
    "track2",
    "track3",
    "track4",
    "track5"
}

local function play_music_track(playername, track_index)
    local player = minetest.get_player_by_name(playername)
    if not player then return end

    if current_music[playername] then
        minetest.sound_stop(current_music[playername])
        current_music[playername] = nil
    end

    if not tracks[track_index] then
        return false, "❌ Invalid track index: " .. tostring(track_index)
    end

    player_track_index[playername] = track_index
    local volume = player_volume[playername] or 1.0
    local track = tracks[track_index]

    current_music[playername] = minetest.sound_play(track, {
        to_player = playername,
        gain = volume,
    })

    return true, "🎶 Playing track: " .. track
end

minetest.register_chatcommand("music1", {
    description = "Play music track 1",
    func = function(name) return play_music_track(name, 1) end
})

minetest.register_chatcommand("music2", {
    description = "Play music track 2",
    func = function(name) return play_music_track(name, 2) end
})

minetest.register_chatcommand("music3", {
    description = "Play music track 3",
    func = function(name) return play_music_track(name, 3) end
})

minetest.register_chatcommand("music4", {
    description = "Play music track 4",
    func = function(name) return play_music_track(name, 4) end
})

minetest.register_chatcommand("music5", {
    description = "Play music track 5",
    func = function(name) return play_music_track(name, 5) end
})

minetest.register_chatcommand("stopmusic", {
    description = "Stop currently playing music",
    func = function(name)
        if current_music[name] then
            minetest.sound_stop(current_music[name])
            current_music[name] = nil
            return true, " Music stopped."
        else
            return false, " No music is currently playing."
        end
    end
})

minetest.register_chatcommand("musicvol", {
    params = "<0.0 - 1.0>",
    description = "Set your music volume",
    func = function(name, param)
        local vol = tonumber(param)
        if not vol or vol < 0 or vol > 1 then
            return false, " Volume must be between 0.0 and 1.0"
        end
        player_volume[name] = vol
        return true, "🔊 Volume set to " .. vol
    end
})
