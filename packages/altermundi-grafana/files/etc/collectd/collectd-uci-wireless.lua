#!/usr/bin/lua
local libuci = require("uci")

local uci = libuci.cursor()

local hostname
uci:foreach("system", "system", function(s) hostname = uci:get("system", s[".name"], "hostname") end)

uci:foreach("wireless", "wifi-device",
  function(s)
    local distance = uci:get("wireless", s[".name"], "distance")
    if distance ~= nil then
      print(
        "PUTVAL"..
        " "..hostname.."/uci-wireless_distance/gauge-"..s[".name"]..
        " N:"..distance
      )
    end
  end
)

uci:foreach("wireless", "wifi-iface", 
  function(s)
    local mcast_rate = uci:get("wireless", s[".name"], "mcast_rate")
    local ifname = uci:get("wireless", s[".name"], "ifname")
    if mcast_rate ~= nil then
      print(
        "PUTVAL"..
        " "..hostname.."/uci-wireless_mcast_rate/gauge-"..ifname..
        " N:"..mcast_rate
      )
    end
  end
)

uci:close()
