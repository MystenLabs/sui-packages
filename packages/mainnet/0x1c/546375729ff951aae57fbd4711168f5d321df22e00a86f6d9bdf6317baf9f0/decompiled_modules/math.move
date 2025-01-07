module 0x1c546375729ff951aae57fbd4711168f5d321df22e00a86f6d9bdf6317baf9f0::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_div_to_u128(arg0: u64, arg1: u64, arg2: u64) : u128 {
        assert!(arg2 != 0, 500);
        (arg0 as u128) * (arg1 as u128) / (arg2 as u128)
    }

    public fun mul_div_to_u256(arg0: u64, arg1: u64, arg2: u64) : u256 {
        assert!(arg2 != 0, 500);
        (arg0 as u256) * (arg1 as u256) / (arg2 as u256)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = arg0 * arg1 / arg2;
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 500);
        arg0 * arg1 / arg2
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun sqrt(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

