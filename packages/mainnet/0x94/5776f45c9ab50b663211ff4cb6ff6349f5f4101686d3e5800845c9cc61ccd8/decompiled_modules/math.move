module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math {
    public fun bps_denom() : u64 {
        10000
    }

    public fun invariant_k(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun pow10(arg0: u8) : u128 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun spot_price_scaled(arg0: u64, arg1: u64, arg2: u8) : u128 {
        if (arg1 == 0) {
            return 0
        };
        (arg0 as u128) * pow10(arg2) * 1000000000000 / (arg1 as u128)
    }

    public fun sui_in_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0);
        assert!(arg2 < arg1, 1);
        if (arg2 == 0) {
            return 0
        };
        let v0 = (arg1 as u128) - (arg2 as u128);
        (((invariant_k(arg0, arg1) + v0 - 1) / v0 - (arg0 as u128)) as u64)
    }

    public fun sui_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0);
        if (arg2 == 0) {
            return 0
        };
        let v0 = (arg1 as u128) + (arg2 as u128);
        let v1 = (invariant_k(arg0, arg1) + v0 - 1) / v0;
        let v2 = (arg0 as u128);
        if (v1 >= v2) {
            0
        } else {
            ((v2 - v1) as u64)
        }
    }

    public fun tokens_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0);
        if (arg2 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) + (arg2 as u128);
        let v1 = (invariant_k(arg0, arg1) + v0 - 1) / v0;
        let v2 = (arg1 as u128);
        if (v1 >= v2) {
            0
        } else {
            ((v2 - v1) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

