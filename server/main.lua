function tablePrintOut(table)
    if type(table) == 'table' then
       local s = '\n{ '
       for k,v in pairs(table) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. tablePrintOut(v) .. ',\n'
       end
       return s .. '}'
    else
       return tostring(table)
    end
 end

-- example how to trigger it

-- print(tablePrintOut(src))

local xplist = {}

-- xplist = {
--     ["crafting"] = 0,
--     ["driving"] = 0,
--     ["hacking"] = 0,
-- }

RegisterServerEvent('xnlrankbar:server:getxp')
AddEventHandler('xnlrankbar:server:getxp', function(player)
    local result = exports.oxmysql:executeSync('SELECT cid FROM xnlrankbar WHERE cid = ?', { player.citizenid })
    if result[1] == nil then
        print("new player setting everything to 0")
        exports.oxmysql:insert('INSERT INTO xnlrankbar (cid)VALUES(?)', {player.citizenid})
    end
end)

RegisterServerEvent('xnlrankbar:server:craftingxp')
AddEventHandler('xnlrankbar:server:craftingxp', function(XPAmount,player)
    exports.oxmysql:update('UPDATE xnlrankbar SET crafting = ? WHERE cid = ?', {XPAmount,player})
end)

RegisterServerEvent('xnlrankbar:server:setxp')
AddEventHandler('xnlrankbar:server:setxp', function(XPAmount,player)
    exports.oxmysql:insert('INSERT INTO xnlrankbar (cid, xnlrankbar )VALUES(?,?)', {player.citizenid,XPAmount})
end)