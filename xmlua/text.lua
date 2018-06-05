local Text = {}

local libxml2 = require("xmlua.libxml2")
local Node = require("xmlua.node")

local methods = {}

local metatable = {}

function metatable.__index(element, key)
  return methods[key] or
    Node[key]
end

function methods:text()
  return self:content()
end

function methods:concat(content)
  return libxml2.xmlTextConcat(self.node,
                               content,
                               content:len()) == 0
end

function methods:merge(merge_node)
  libxml2.xmlTextMerge(self.node, merge_node.node)
end

function Text.new(document, node)
  local text = {
    document = document,
    node = node,
  }
  setmetatable(text, metatable)
  return text
end

return Text
