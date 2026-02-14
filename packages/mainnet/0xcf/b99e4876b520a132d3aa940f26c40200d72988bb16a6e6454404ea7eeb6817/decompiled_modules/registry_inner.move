module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::registry_inner {
    public(friend) fun calculate_trading_cutoff(arg0: u64, arg1: u8) : u64 {
        let v0 = &arg1;
        let v1 = if (*v0 == 0) {
            120000
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

    public(friend) fun compute_prices(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = arg0 + arg1;
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = (((arg1 as u128) * 1000000 / (v0 as u128)) as u64);
        (v1, 1000000 - v1)
    }

    public(friend) fun validate_fee(arg0: u16) : bool {
        (arg0 as u64) < 5000
    }

    // decompiled from Move bytecode v6
}

