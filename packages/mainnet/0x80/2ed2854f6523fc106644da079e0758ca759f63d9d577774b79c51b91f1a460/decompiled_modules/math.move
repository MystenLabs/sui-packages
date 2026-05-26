module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::math {
    public fun div_rounding_up_u128(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 / arg1;
        let v1 = v0;
        if (arg0 % arg1 > 0) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun div_rounding_up_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 / arg1;
        let v1 = v0;
        if (arg0 % arg1 > 0) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun mul_div_rounding_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = mul_div_u128(arg0, arg1, arg2);
        let v1 = v0;
        if (mul_mod_u128(arg0, arg1, arg2) > 0) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun mul_div_rounding_up_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = mul_div_u64(arg0, arg1, arg2);
        let v1 = v0;
        if (mul_mod_u64(arg0, arg1, arg2) > 0) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 1);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_mod_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) % (arg2 as u256)) as u128)
    }

    fun mul_mod_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) % (arg2 as u128)) as u64)
    }

    public fun overflow_add_u256(arg0: u256, arg1: u256) : u256 {
        if (115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 >= arg1) {
            arg0 + arg1
        } else {
            arg1 - 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 - 1
        }
    }

    fun overflow_sub_u256(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 + arg0 + 1, true)
        }
    }

    public fun wrapping_sub_u256(arg0: u256, arg1: u256) : u256 {
        let (v0, _) = overflow_sub_u256(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v7
}

