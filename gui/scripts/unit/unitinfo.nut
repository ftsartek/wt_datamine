from "%scripts/dagui_library.nut" import *
let u = require("%sqStdLibs/helpers/u.nut")
let { getCountryIcon } = require("%scripts/options/countryFlagsPreset.nut")
let { get_ranks_blk } = require("blkGetters")
let { isUnlockOpened } = require("%scripts/unlocks/unlocksModule.nut")

enum bit_unit_status {
  locked      = 1
  canResearch = 2
  inResearch  = 4
  researched  = 8
  canBuy      = 16
  owned       = 32
  mounted     = 64
  disabled    = 128
  broken      = 256
  inRent      = 512
  empty       = 1024
}

function getEsUnitType(unit) {
  return unit?.esUnitType ?? ES_UNIT_TYPE_INVALID
}

function getUnitTypeTextByUnit(unit) {
  return ::getUnitTypeText(getEsUnitType(unit))
}

function getUnitCountry(unit) {
  return unit?.shopCountry ?? ""
}

function isUnitsEraUnlocked(unit) {
  return ::is_era_available(getUnitCountry(unit), unit?.rank ?? -1, getEsUnitType(unit))
}

function getUnitName(unit, shopName = true) {
  let unitId = u.isUnit(unit) ? unit.name
    : u.isString(unit) ? unit
    : ""
  let localized = loc($"{unitId}{shopName ? "_shop" : "_0"}", unitId)
  return shopName ? ::stringReplace(localized, " ", nbsp) : localized
}

function isUnitDefault(unit) {
  if (!("name" in unit))
    return false
  return ::is_default_aircraft(unit.name)
}

function isUnitGift(unit) {
  return unit.gift != null
}

function getUnitCountryIcon(unit, needOperatorCountry = false) {
  return getCountryIcon(needOperatorCountry ? unit.getOperatorCountry() : unit.shopCountry)
}

function getUnitsNeedBuyToOpenNextInEra(countryId, unitType, rank, ranksBlk = null) {
  ranksBlk = ranksBlk || get_ranks_blk()
  let unitTypeText = ::getUnitTypeText(unitType)

  local rankToOpen = ranksBlk?.needBuyToOpenNextInEra[countryId][$"needBuyToOpenNextInEra{unitTypeText}{rank}"]
  if (rankToOpen != null)
    return rankToOpen

  rankToOpen = ranksBlk?.needBuyToOpenNextInEra[countryId][$"needBuyToOpenNextInEra{rank}"]
  if (rankToOpen != null)
    return rankToOpen

  return -1
}

function isUnitGroup(unit) {
  return unit && "airsGroup" in unit
}

function isGroupPart(unit) {
  return unit && unit.group != null
}

function canResearchUnit(unit) {
  let isInShop = unit?.isInShop
  if (isInShop == null) {
    debugTableData(unit)
    assert(false, "not existing isInShop param")
    return false
  }

  if (!isInShop)
    return false

  if (unit.reqUnlock && !isUnlockOpened(unit.reqUnlock))
    return false

  let status = ::shop_unit_research_status(unit.name)
  return (0 != (status & (ES_ITEM_STATUS_IN_RESEARCH | ES_ITEM_STATUS_CAN_RESEARCH))) && !::isUnitMaxExp(unit)
}

let isRequireUnlockForUnit = @(unit) unit?.reqUnlock != null && !isUnlockOpened(unit.reqUnlock)

return {
  bit_unit_status
  getEsUnitType, getUnitTypeTextByUnit, isUnitsEraUnlocked, getUnitName,//next
  getUnitCountry, isUnitDefault, isUnitGift, getUnitCountryIcon, getUnitsNeedBuyToOpenNextInEra,
  isUnitGroup, isGroupPart, canResearchUnit
  isRequireUnlockForUnit
}