local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('v:base', {
    t { '<script setup lang="ts">', '' },
    i(1, ''),
    t { '', '</script>', '', '', '<template>', '</template>' },
  }),
  s('nitro:event', {
    t 'export default defineEventHandler(async (event) => {',
    t { '', '  ' },
    i(1, ''),
    t { '', '});' },
  }),
}
