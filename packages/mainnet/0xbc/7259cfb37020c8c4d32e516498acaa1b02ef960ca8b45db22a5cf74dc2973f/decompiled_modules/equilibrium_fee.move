module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::equilibrium_fee {
    public fun calculate_equilibrium_fee(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        if (arg3 == 0 || arg1 == arg0) {
            return 0
        };
        if (calculate_liquidity_percent(arg1 - arg2, arg0 - arg2, arg3) > arg4) {
            return 0
        };
        let v0 = if (calculate_liquidity_percent(arg1, arg0, arg3) > arg4) {
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg1 - 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg0, arg4), arg3), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray() - 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg4, arg3))
        } else {
            0
        };
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul((arg0 - arg1) * 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg5, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_ln2()), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_log2(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg0 - v0, arg0 - arg2))) / 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg4, arg3) - (arg2 - v0) * 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg5, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray() - 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg4, arg3)) / 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg4, arg3)
    }

    public fun calculate_equilibrium_reward(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        if (arg3 == 0 || arg4 == 0) {
            return 0
        };
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg4, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::min(calculate_liquidity_percent(arg1 + arg2, arg0 + arg2, arg3) - calculate_liquidity_percent(arg1, arg0, arg3), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::min(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg2, 2 * 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg4, arg5)), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray())))
    }

    public fun calculate_expected_ratio(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg1, arg0)
        }
    }

    public fun calculate_liquidity_percent(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 == 0) {
            0
        } else {
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::min(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div(arg0, arg1), arg2), 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray())
        }
    }

    // decompiled from Move bytecode v6
}

