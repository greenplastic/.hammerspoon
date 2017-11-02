-- Requires an API Access Token from Bit.ly
local BITLY_API_ACCESS_TOKEN = "97208cb42015a6c96a51f0a800cfa5372c06e3f7"

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", function()
    local board = hs.pasteboard.getContents()

    if board:match("^https?://") then
        local response = hs.http.asyncGet(
            "https://api-ssl.bitly.com/v3/shorten" ..
            "?access_token=" .. BITLY_API_ACCESS_TOKEN ..
            "&longUrl=" .. hs.http.encodeForQuery(board),
            {},
            function(status, response, headers)
                if status == 200 then
                    local msg = hs.json.decode(response)

                    hs.pasteboard.setContents(msg.data.url)
                    hs.notify.new({title="Bitly URL Shorten: Success", informativeText=msg.data.url}):send()
                else
                    hs.notify.new({title="Bitly URL Shorten: Failure", informativeText=response}):send()
                end
            end
        )
    else
        hs.notify.new({title="Bitly URL Shorten: Failure", informativeText="Expected: URL"}):send()
    end
end)
