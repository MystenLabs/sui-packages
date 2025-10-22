module 0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::math {
    public fun get_auto_rebalance_min_liquidity(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u64) : u128 {
        let v0 = get_liquidity_in_y(arg0, arg1, arg2);
        0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::safe_math::mul_div_u128(v0 - 0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::safe_math::mul_div_u128(v0, (arg3 as u128), 0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::constants::scaling_pips_u128()), (arg4 as u128), 0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::constants::scaling_pips_u128())
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
        0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::safe_math::mul_div_Q64(0x9e4db210d5e6670b50131a27e4fd5175930ee126fa72e5350396aa8193ef6627::safe_math::mul_div_Q64((arg0 as u256), v0), v0 - (arg3 as u256)) > (arg1 as u256) * (v1 - v0) / v1
    }

    // decompiled from Move bytecode v6
}

