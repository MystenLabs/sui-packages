module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math {
    public fun amount_to_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return arg0
        };
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun bps_base() : u64 {
        10000
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 2);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun safe_div(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 / arg1
    }

    public fun share_price(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000000000
        };
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    public fun shares_to_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

