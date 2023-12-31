enum WW_LB_MODE {
  WW_USERS          = 0x00001
  WW_CLANS          = 0x00002
  WW_COUNTRIES      = 0x00004
  WW_CLANS_MANAGER  = 0x00010
  WW_USERS_CLAN     = 0x00020

  ALL               = 0xFFFFF
}

const LEADERBOARD_VALUE_TOTAL = "value_total"
const LEADERBOARD_VALUE_INHISTORY = "value_inhistory"

return {
  WW_LB_MODE
  LEADERBOARD_VALUE_TOTAL
  LEADERBOARD_VALUE_INHISTORY
}