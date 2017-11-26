local luaunit = require("luaunit")
local xmlua = require("xmlua")

TestSearch = {}

function TestSearch.test_invalid()
  local document = xmlua.XML.parse([[
<root>
  <sub class="A"/>
  <sub class="A"/>
  <sub class="B"/>
</root>
]])
  local success, err = pcall(function() document:search("") end)
  luaunit.assertEquals(success, false)
  luaunit.assertEquals(err, {message = "Invalid expression\n"})
end

function TestSearch.test_no_match()
  local document = xmlua.XML.parse([[
<root>
  <sub class="A"/>
  <sub class="A"/>
  <sub class="B"/>
</root>
]])
  luaunit.assertEquals(#document:search("/nonexistent"),
                       0)
end

function TestSearch.test_multiple()
  local document = xmlua.XML.parse([[
<root>
  <sub class="A"/>
  <sub class="A"/>
  <sub class="B"/>
</root>
]])
  luaunit.assertEquals(#document:search("/root/sub[@class='A']"),
                       2)
end
