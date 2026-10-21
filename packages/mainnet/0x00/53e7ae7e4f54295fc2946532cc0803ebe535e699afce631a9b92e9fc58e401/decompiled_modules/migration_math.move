module 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::migration_math {
    public(friend) fun auto_lp_fixed_side(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : (bool, u64) {
        if (arg1 <= arg0 || arg1 >= arg2) {
            return (true, 0)
        };
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        if (can_fix_a(v0, v1, v2, arg3, arg4)) {
            return (true, arg3)
        };
        if (can_fix_b(v0, v1, v2, arg3, arg4)) {
            return (false, arg4)
        };
        (true, 0)
    }

    fun can_fix_a(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : bool {
        let v0 = 18446744073709551616;
        let v1 = (arg3 as u256) * arg1 * arg2 / v0 / (arg2 - arg1);
        if (v1 == 0 || v1 >= 340282366920938463463374607431768211456) {
            return false
        };
        0x1::u256::div_ceil(v1 * (arg1 - arg0), v0) + 2 <= (arg4 as u256)
    }

    fun can_fix_b(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : bool {
        let v0 = ((arg4 as u256) << 64) / (arg1 - arg0);
        if (v0 == 0) {
            return false
        };
        0x1::u256::div_ceil(v0 << 64, arg1) - (v0 << 64) / arg2 + 2 <= (arg3 as u256)
    }

    fun integer_sqrt(arg0: u256) : u128 {
        let v0 = 0;
        let v1 = 79228162514264337593543950336;
        while (v0 + 1 < v1) {
            v1 = (v0 + v1) / 2;
            if (v1 * v1 <= arg0) {
                v0 = v1;
                continue
            };
        };
        (v0 as u128)
    }

    fun ratio_q128(arg0: u64, arg1: u64, arg2: bool) : u256 {
        let (v0, v1) = if (arg2) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        };
        ((v0 as u256) << 128) / (v1 as u256)
    }

    public(friend) fun sqrt_price_x64(arg0: u64, arg1: u64, arg2: bool) : u128 {
        integer_sqrt(ratio_q128(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v7
}

