module 0xda4af1bc25fdf01fab1284cec4f2fb36a2ccddb7a1dd0fbdae7f88d4f44ddb40::farming_math {
    public fun checked_mul_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 101);
        (v0 as u128)
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 100);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 101);
        (v0 as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 100);
        let v0 = (arg2 as u256);
        let v1 = ((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0;
        assert!(v1 <= 340282366920938463463374607431768211455, 101);
        (v1 as u128)
    }

    public fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 101);
        (arg0 as u64)
    }

    public fun to_u64_saturating(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

