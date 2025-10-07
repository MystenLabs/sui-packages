module 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::math {
    public fun mul_div_mixed(arg0: u128, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        (v0 as u128)
    }

    public fun mul_div_to_128(arg0: u64, arg1: u64, arg2: u64) : u128 {
        assert!(arg2 != 0, 1);
        (arg0 as u128) * (arg1 as u128) / (arg2 as u128)
    }

    public fun mul_div_to_64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg2 as u128);
        let v1 = (arg0 as u128) * (arg1 as u128);
        let v2 = if (v1 == 0) {
            0
        } else {
            (v1 + v0 - 1) / v0
        };
        assert!(v2 <= 18446744073709551615, 0);
        (v2 as u64)
    }

    public fun safe_u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 2);
        (arg0 as u64)
    }

    public fun saturating_add(arg0: u128, arg1: u128) : u128 {
        if (340282366920938463463374607431768211455 - arg0 < arg1) {
            340282366920938463463374607431768211455
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            0
        } else {
            arg0 - arg1
        }
    }

    // decompiled from Move bytecode v6
}

