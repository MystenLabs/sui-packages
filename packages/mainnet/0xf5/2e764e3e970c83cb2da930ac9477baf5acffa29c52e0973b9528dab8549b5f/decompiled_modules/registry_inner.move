module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner {
    public(friend) fun calculate_trading_cutoff(arg0: &0x2::object::UID, arg1: u64, arg2: u8) : u64 {
        arg1 - 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config::cutoff_ms(arg0, arg2)
    }

    public(friend) fun validate_cutoff(arg0: u64) : bool {
        arg0 >= 10000 && arg0 <= 43200000
    }

    public(friend) fun validate_deposit_fee(arg0: u16) : bool {
        (arg0 as u64) < 5000
    }

    public(friend) fun validate_fee(arg0: u16) : bool {
        (arg0 as u64) < 5000
    }

    // decompiled from Move bytecode v6
}

