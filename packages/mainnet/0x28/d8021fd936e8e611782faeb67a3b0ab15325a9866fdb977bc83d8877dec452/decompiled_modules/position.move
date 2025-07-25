module 0x28d8021fd936e8e611782faeb67a3b0ab15325a9866fdb977bc83d8877dec452::position {
    struct OTW has drop {
        dummy_field: bool,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        total_increases: u64,
        total_decreases: u64,
        last_action: u64,
    }

    public fun create_position_with_display(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id              : 0x2::object::new(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            name            : arg0,
            image_url       : 0x1::string::utf8(b"https://i0.wp.com/grapevine.is/wp-content/uploads/2020/07/volcano-eruption-adobestock_94444001-scaled.jpeg?fit=2560%2C1707&quality=99&ssl=1"),
            total_increases : 0,
            total_decreases : 0,
            last_action     : 0,
        }
    }

    public fun decrease(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.total_decreases = arg0.total_decreases + arg1;
        arg0.last_action = arg2;
    }

    public fun get_last_action(arg0: &Position) : u64 {
        arg0.last_action
    }

    public fun get_total_decreases(arg0: &Position) : u64 {
        arg0.total_decreases
    }

    public fun get_total_increases(arg0: &Position) : u64 {
        arg0.total_increases
    }

    public fun increase(arg0: &mut Position, arg1: u64, arg2: u64) {
        arg0.total_increases = arg0.total_increases + arg1;
        arg0.last_action = arg2;
    }

    // decompiled from Move bytecode v6
}

