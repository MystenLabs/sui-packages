module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result {
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

    public fun arrest_attempted(arg0: &RaidResult) : bool {
        arg0.arrest_attempted
    }

    public fun attempted_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.attempted_item_id
    }

    public fun avoided_arrest(arg0: &RaidResult) : bool {
        arg0.avoided_arrest
    }

    public fun item_confiscated(arg0: &RaidResult) : bool {
        arg0.item_confiscated
    }

    public fun item_obtained(arg0: &RaidResult) : bool {
        arg0.item_obtained
    }

    public fun luck_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.luck_item_id
    }

    public fun luck_triggered(arg0: &RaidResult) : bool {
        arg0.luck_triggered
    }

    public fun new_raid_result(arg0: 0x1::option::Option<u64>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: 0x1::option::Option<u8>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: u64) : RaidResult {
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

    public fun original_item_id(arg0: &RaidResult) : &0x1::option::Option<u64> {
        &arg0.original_item_id
    }

    public fun save_reason(arg0: &RaidResult) : &0x1::option::Option<u8> {
        &arg0.save_reason
    }

    public fun stamina_consumed(arg0: &RaidResult) : u64 {
        arg0.stamina_consumed
    }

    public fun wanted_gained(arg0: &RaidResult) : u64 {
        arg0.wanted_gained
    }

    // decompiled from Move bytecode v6
}

