enum squadMemberState {
  NOT_IN_SQUAD
  SQUAD_LEADER //leader cant be offline or not ready.
  SQUAD_MEMBER
  SQUAD_MEMBER_READY
  SQUAD_MEMBER_OFFLINE
}


enum memberStatus {
  READY
  SELECTED_AIRS_BROKEN
  NO_REQUIRED_UNITS
  SELECTED_AIRS_NOT_AVAILABLE
  ALL_AVAILABLE_AIRS_BROKEN
  PARTLY_AVAILABLE_AIRS_BROKEN
  AIRS_NOT_AVAILABLE
  EAC_NOT_INITED
}

enum squadState {
  NOT_IN_SQUAD
  JOINING
  IN_SQUAD
  LEAVING
}


const SQUADS_VERSION = 2

return {
  squadMemberState
  memberStatus
  squadState
  SQUADS_VERSION
}