require 'caffeine'
require 'altDoublePress'
-- require 'cmdDoublePress'
require 'ctrlDoublePress'
require 'fnDoublePress'
require 'shiftDoublePress'
require 'keyremap'
require 'url_shortener'
require 'commandToKanaEisu'

-- Fancy configuration reloading
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- sleep
hs.hotkey.bind({"cmd", "alt"}, "return", function()
    hs.caffeinate.systemSleep()
end)

-- hammerspoon reload
hs.hotkey.bind({"cmd", "alt"}, "r", function()
    hs.reload()
    hs.alert.show("Config loaded")
end)
