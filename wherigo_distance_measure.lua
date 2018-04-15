--
-- Created by IntelliJ IDEA.
-- User: andi
-- Date: 19.04.12
-- Time: 19:00
-- To change this template use File | Settings | File Templates.
--

-- LUA Code to measure distance of Player
-- Interface to Urwigo:
--
-- init-routine:      store_current_position() - should be called on start of measurement or after restore of cartridge
-- walked_distance(): should be called via timer - e.g. every one or 2 seconds


local last_pos = ZonePoint(0,0,0)  --not persistent, so init-function should be called after restore of cartridge


function store_current_position()
    --just store the current position
    last_pos = Player.ObjectLocation
end


function get_gps_accuracy()
    local pos_acc = Player.PositionAccuracy
    local gps_acc = pos_acc:GetValue 'm'
    return gps_acc
end


function walked_distance()  --return walked_distance - if more than twice position accuracy
   --try to work with PositionAccuracy

   local d, b = Wherigo.VectorToPoint(last_pos, Player.ObjectLocation)
   local dn = d:GetValue 'm'
   local gps_acc = get_gps_accuracy()
   if dn > 2 * gps_acc then
       store_current_position()
       --not used last_bearing = b - if it is interesting in which direction player is walking
       return dn  --return distance
   end
   return 0
end