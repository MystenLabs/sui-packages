module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math {
    public fun bps() : u64 {
        10000
    }

    public fun deviation_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        saturate((v0 as u256) * (10000 as u256) / (arg1 as u256))
    }

    public fun e18() : u128 {
        1000000000000000000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        saturate((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u256);
        saturate(((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0)
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun saturate(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    public fun scale_to_e18(arg0: u64, arg1: bool, arg2: u64) : u128 {
        let v0 = if (arg1) {
            if (arg2 <= 18) {
                (arg0 as u256) * pow10(((18 - arg2) as u8))
            } else {
                (arg0 as u256) / pow10(((arg2 - 18) as u8))
            }
        } else {
            (arg0 as u256) * pow10(((18 + arg2) as u8))
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        (v0 as u128)
    }

    public fun units_to_usd(arg0: u64, arg1: u128, arg2: u8) : u64 {
        saturate((arg0 as u256) * (arg1 as u256) / pow10(arg2) * 1000000000000)
    }

    public fun usd_to_units(arg0: u64, arg1: u128, arg2: u8) : u64 {
        saturate((arg0 as u256) * pow10(arg2) * 1000000000000 / (arg1 as u256))
    }

    public fun usd_to_units_up(arg0: u64, arg1: u128, arg2: u8) : u64 {
        let v0 = (arg1 as u256);
        saturate(((arg0 as u256) * pow10(arg2) * 1000000000000 + v0 - 1) / v0)
    }

    // decompiled from Move bytecode v7
}

