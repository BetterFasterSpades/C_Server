-- level.lua: A simple lua script showcasing SapdesX's scripting capabilities.

notice = require('notice')

-- Babel: Prevent players from destroying top platform.
-- Also prevent people from same team to destroy their own tower.
function gamemode_block_checks(player, x, y, z)
    if (((((x >= 206 and x <= 306) and (y >= 240 and y <= 272) and (z == 2 or z == 0)) or
          ((x >= 205 and x <= 307) and (y >= 239 and y <= 273) and (z == 1)))))
    then
        notice.send_to(player.id, "You should try to destroy the ennemy's tower... Not the platform!")
        return 0
    end
    -- Prevent players from destroying their own tower.
    if (player.team == 1 and x > 512-220) or ( player.team == 0 and x < 220)  then
        notice.send_to(player.id, "You should try to destroy the ennemy's tower... It is not on this side of the map!")
        return 0
    end

    return 1
end

function gamemode_init(api)
    -- Let's add some snow to the map:
    for x = 0,450, 1
    do 
        for y = 0,450, 1
        do 
            api.add_colored_block(x,y,api.find_top_block(x,y), 0xffffff)
        end
    end
    -- Babel: create platform:
    for x = 206, 306 do
        for y = 240, 272 do
            api.add_colored_block(x, y, 1, 0xFF00FFFF)
        end
    end
end