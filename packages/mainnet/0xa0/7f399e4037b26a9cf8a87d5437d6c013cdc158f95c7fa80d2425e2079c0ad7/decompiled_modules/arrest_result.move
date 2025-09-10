module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::arrest_result {
    struct ArrestResult has drop {
        arrest_attempted: bool,
        avoided_arrest: bool,
        save_reason: 0x1::option::Option<u8>,
    }

    public(friend) fun arrest_attempted(arg0: &ArrestResult) : bool {
        arg0.arrest_attempted
    }

    public(friend) fun avoided_arrest(arg0: &ArrestResult) : bool {
        arg0.avoided_arrest
    }

    public(friend) fun new_arrested() : ArrestResult {
        ArrestResult{
            arrest_attempted : true,
            avoided_arrest   : false,
            save_reason      : 0x1::option::none<u8>(),
        }
    }

    public(friend) fun new_avoided(arg0: u8) : ArrestResult {
        ArrestResult{
            arrest_attempted : true,
            avoided_arrest   : true,
            save_reason      : 0x1::option::some<u8>(arg0),
        }
    }

    public(friend) fun new_no_arrest() : ArrestResult {
        ArrestResult{
            arrest_attempted : false,
            avoided_arrest   : false,
            save_reason      : 0x1::option::none<u8>(),
        }
    }

    public(friend) fun save_reason(arg0: &ArrestResult) : &0x1::option::Option<u8> {
        &arg0.save_reason
    }

    public(friend) fun save_reason_endurance() : u8 {
        1
    }

    public(friend) fun save_reason_luck() : u8 {
        3
    }

    public(friend) fun save_reason_stealth() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

