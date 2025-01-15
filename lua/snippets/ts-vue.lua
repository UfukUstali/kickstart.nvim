local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("v:base", {
    t({ '<script setup lang="ts">', "" }),
    i(1, "put the cursor here"),
    t({ "", "</script>", "", "", "<template>", "</template>" }),
  }),
  s("nitro:event", {
    t("export default defineEventHandler(async (event) => {"),
    t({"", "  "}), -- Indentation
    i(1, "// cursor goes here"), -- Placeholder for the cursor
    t({"", "});"}),
  }),
}
