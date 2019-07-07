local qiwi = "71231234567" // QIWI Кошелёк, на который делать вывод средств

timer.Create("DogDonate",10,0,function() // Не больше 1 запроса в 10 сек
    http.Fetch("https://dogdonate.ru/get.php?qiwi="..qiwi.."&rand="..math.random(1,99999999).."&ref=", function(body, len, headers, code)
        local b = util.JSONToTable(body)
        if not istable(b) then return end
        for k, v in pairs(b) do
            local pl = player.GetBySteamID(k)
            v = tonumber(v)
            if not IsValid(pl) then // Игрока нет на сервере , k - SteamID, v - Сумма
                util.SetPData(k, 'gd_money', tonumber(util.GetPData(k, "gd_money", 0)) + v)
            else // Игрок есть на сервере, pl - Игрок, v - Сумма доната
                pl:SetPData("gd_money", tonumber(pl:GetPData("gd_money", 0)) + v)
            end
        end
    end, function(error) print(error) end)
end)
