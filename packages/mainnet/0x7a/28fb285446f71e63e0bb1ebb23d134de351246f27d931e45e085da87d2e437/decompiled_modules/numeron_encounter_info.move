module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info {
    struct EncounterInfo has copy, drop, store {
        monster_id: u256,
        is_battling: bool,
    }

    public fun get(arg0: &EncounterInfo) : (u256, bool) {
        (arg0.monster_id, arg0.is_battling)
    }

    public fun get_is_battling(arg0: &EncounterInfo) : bool {
        arg0.is_battling
    }

    public fun get_monster_id(arg0: &EncounterInfo) : u256 {
        arg0.monster_id
    }

    public fun new(arg0: u256, arg1: bool) : EncounterInfo {
        EncounterInfo{
            monster_id  : arg0,
            is_battling : arg1,
        }
    }

    public(friend) fun set(arg0: &mut EncounterInfo, arg1: u256, arg2: bool) {
        arg0.monster_id = arg1;
        arg0.is_battling = arg2;
    }

    public(friend) fun set_is_battling(arg0: &mut EncounterInfo, arg1: bool) {
        arg0.is_battling = arg1;
    }

    public(friend) fun set_monster_id(arg0: &mut EncounterInfo, arg1: u256) {
        arg0.monster_id = arg1;
    }

    // decompiled from Move bytecode v6
}

