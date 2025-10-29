module 0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::math {
    public fun get_auto_rebalance_min_liquidity(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = get_liquidity_in_y(arg0, arg1, arg2);
        0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::safe_math::mul_div_u128(v0 - 0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::safe_math::mul_div_u128(v0, (arg3 as u128), 0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::constants::scaling_pips_u128()), (arg4 as u128), 0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::constants::scaling_pips_u128())
    }

    public fun get_liquidity_in_y(arg0: u64, arg1: u64, arg2: u128) : u128 {
        (((arg0 as u256) * (arg2 as u256) * (arg2 as u256) >> 128) as u128) + (arg1 as u128)
    }

    public fun is_zero_for_one(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : bool {
        if (arg2 <= arg3) {
            return false
        };
        if (arg2 >= arg4) {
            return true
        };
        let v0 = (arg2 as u256);
        let v1 = (arg4 as u256);
        0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::safe_math::mul_div_Q64(0x58c9bcc5dc3dd6fc254e521a53ccdbf4a84d107ce963c7c4625e6159d1e0345a::safe_math::mul_div_Q64((arg0 as u256), v0), v0 - (arg3 as u256)) > (arg1 as u256) * (v1 - v0) / v1
    }

    // decompiled from Move bytecode v6
}

