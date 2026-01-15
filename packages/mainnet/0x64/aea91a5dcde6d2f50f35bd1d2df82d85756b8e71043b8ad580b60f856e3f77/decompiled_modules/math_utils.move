module 0x64aea91a5dcde6d2f50f35bd1d2df82d85756b8e71043b8ad580b60f856e3f77::math_utils {
    public fun calculate_price_amount(arg0: u64, arg1: u64, arg2: u8, arg3: u8, arg4: u8) : (u64, bool) {
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u64) + (arg3 as u64);
        let v2 = (arg4 as u64);
        let (v3, v4) = if (v1 >= v2) {
            let v5 = (safe_pow(10, ((v1 - v2) as u128)) as u256);
            (v0 / v5, v0 % v5 > 0)
        } else {
            (v0 * (safe_pow(10, ((v2 - v1) as u128)) as u256), false)
        };
        assert!(v3 <= (18446744073709551615 as u256), 1);
        ((v3 as u64), v4)
    }

    public fun calculate_token_from_price(arg0: u64, arg1: u8, arg2: u64, arg3: u8, arg4: u8, arg5: u8) : (u64, bool) {
        let v0 = (arg4 as u64) + (arg5 as u64);
        let v1 = (arg1 as u64);
        let v2 = (arg0 as u256);
        let v3 = (arg2 as u256);
        let (v4, v5) = if (v0 >= v1) {
            let v6 = v2 * (safe_pow(10, ((v0 - v1) as u128)) as u256);
            (v6 / v3, v6 % v3 > 0)
        } else {
            let v7 = v3 * (safe_pow(10, ((v1 - v0) as u128)) as u256);
            (v2 / v7, v2 % v7 > 0)
        };
        assert!(v4 <= (18446744073709551615 as u256), 1);
        ((v4 as u64), v5)
    }

    public fun safe_mul_u128(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun safe_pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 1
        };
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 & 1 == 1) {
                let v1 = (v0 as u256) * (arg0 as u256);
                assert!(v1 <= 340282366920938463463374607431768211455, 1);
                v0 = (v1 as u128);
            };
            if (arg1 > 1) {
                let v2 = (arg0 as u256) * (arg0 as u256);
                assert!(v2 <= 340282366920938463463374607431768211455, 1);
                arg0 = (v2 as u128);
            };
            arg1 = arg1 >> 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

