module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::raid_result {
    struct RaidResult has drop {
        attempted_item_id: 0x1::option::Option<u64>,
        item_obtained: bool,
        item_confiscated: bool,
        arrest_attempted: bool,
        avoided_arrest: bool,
        save_reason: 0x1::option::Option<u8>,
        luck_triggered: bool,
        original_item_id: 0x1::option::Option<u64>,
        luck_item_id: 0x1::option::Option<u64>,
        stamina_consumed: u64,
        wanted_gained: u64,
    }

    public(friend) fun arrest_attempted(arg0: &RaidResult) : bool {
        arg0.arrest_attempted
    }

    public(friend) fun attempted_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.attempted_item_id
    }

    public(friend) fun avoided_arrest(arg0: &RaidResult) : bool {
        arg0.avoided_arrest
    }

    public(friend) fun item_confiscated(arg0: &RaidResult) : bool {
        arg0.item_confiscated
    }

    public(friend) fun item_obtained(arg0: &RaidResult) : bool {
        arg0.item_obtained
    }

    public(friend) fun luck_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.luck_item_id
    }

    public(friend) fun luck_triggered(arg0: &RaidResult) : bool {
        arg0.luck_triggered
    }

    public(friend) fun new_raid_result(arg0: 0x1::option::Option<u64>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: 0x1::option::Option<u8>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: u64) : RaidResult {
        RaidResult{
            attempted_item_id : arg0,
            item_obtained     : arg1,
            item_confiscated  : arg2,
            arrest_attempted  : arg3,
            avoided_arrest    : arg4,
            save_reason       : arg5,
            luck_triggered    : arg6,
            original_item_id  : arg7,
            luck_item_id      : arg8,
            stamina_consumed  : arg9,
            wanted_gained     : arg10,
        }
    }

    public(friend) fun original_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.original_item_id
    }

    public(friend) fun save_reason(arg0: &RaidResult) : &0x1::option::Option<u8> {
        &arg0.save_reason
    }

    public(friend) fun stamina_consumed(arg0: &RaidResult) : u64 {
        arg0.stamina_consumed
    }

    public(friend) fun wanted_gained(arg0: &RaidResult) : u64 {
        arg0.wanted_gained
    }

    // decompiled from Move bytecode v6
}

