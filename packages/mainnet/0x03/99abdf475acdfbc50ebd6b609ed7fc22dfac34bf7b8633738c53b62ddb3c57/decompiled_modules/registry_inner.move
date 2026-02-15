module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry_inner {
    public(friend) fun calculate_trading_cutoff(arg0: u64, arg1: u8) : u64 {
        let v0 = &arg1;
        let v1 = if (*v0 == 0) {
            300000
        } else if (*v0 == 1) {
            300000
        } else if (*v0 == 2) {
            900000
        } else if (*v0 == 3) {
            1800000
        } else if (*v0 == 4) {
            120000
        } else {
            300000
        };
        arg0 - v1
    }

    public(friend) fun validate_fee(arg0: u16) : bool {
        (arg0 as u64) < 5000
    }

    // decompiled from Move bytecode v6
}

