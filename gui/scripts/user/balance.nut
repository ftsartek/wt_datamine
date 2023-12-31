from "%scripts/dagui_library.nut" import *
let { Balance } = require("%scripts/money.nut")

function get_balance() {
  let info = ::get_cur_rank_info()
  return { wp = info.wp, gold = info.gold }
}

function get_gui_balance() {
  let info = ::get_cur_rank_info()
  return Balance(info.wp, info.gold, ::shop_get_free_exp())
}

return {
  get_balance
  get_gui_balance
}