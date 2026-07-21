module 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::clmm_math {
    public fun amount0_delta(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 < arg1, 1);
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        (((arg2 as u256) * (v1 - v0) / v1 * 18446744073709551616 / v0) as u128)
    }

    public fun amount1_delta(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 < arg1, 1);
        (((arg2 as u256) * ((arg1 - arg0) as u256) >> 64) as u128)
    }

    public fun get_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u128, u128) {
        assert!(arg1 < arg2, 1);
        if (arg0 <= arg1) {
            (amount0_delta(arg1, arg2, arg3), 0)
        } else if (arg0 >= arg2) {
            (0, amount1_delta(arg1, arg2, arg3))
        } else {
            (amount0_delta(arg0, arg2, arg3), amount1_delta(arg1, arg0, arg3))
        }
    }

    public fun isqrt(arg0: u256) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v2 = (v1 + arg0 / v1) / 2;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        while (v1 * v1 > arg0) {
            v1 = v1 - 1;
        };
        (v1 as u128)
    }

    public fun position_value_e6(arg0: u64, arg1: u64, arg2: u8, arg3: u8, arg4: u128, arg5: u128, arg6: u128) : u64 {
        let (v0, v1) = get_amounts(sqrt_price_x64_from_prices(arg0, arg1, arg2, arg3), arg4, arg5, arg6);
        (((v0 as u256) * (arg0 as u256) / pow10_u256(arg2)) as u64) + (((v1 as u256) * (arg1 as u256) / pow10_u256(arg3)) as u64)
    }

    fun pow10_u256(arg0: u8) : u256 {
        assert!(arg0 <= 19, 0);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun sqrt_price_x64_from_prices(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u128 {
        isqrt((arg0 as u256) * pow10_u256(arg3) * 340282366920938463463374607431768211456 / (arg1 as u256) * pow10_u256(arg2))
    }

    // decompiled from Move bytecode v7
}

