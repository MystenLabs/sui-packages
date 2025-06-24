module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::equilibrium_fee {
    public fun calculate_equilibrium_fee(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        if (arg3 == 0 || arg1 == arg0) {
            return 0
        };
        if (calculate_liquidity_percent(arg1 - arg2, arg0 - arg2, arg3) > arg4) {
            return 0
        };
        let v0 = if (calculate_liquidity_percent(arg1, arg0, arg3) > arg4) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg1 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg0, arg4), arg3), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg4, arg3))
        } else {
            0
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul((arg0 - arg1) * 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_ln2()), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_log2(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg0 - v0, arg0 - arg2))) / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg4, arg3) - (arg2 - v0) * 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg4, arg3)) / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg4, arg3)
    }

    public fun calculate_equilibrium_reward(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        if (arg3 == 0 || arg4 == 0) {
            return 0
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(calculate_liquidity_percent(arg1 + arg2, arg0 + arg2, arg3) - calculate_liquidity_percent(arg1, arg0, arg3), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg2, 2 * 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg4, arg5)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray())))
    }

    public fun calculate_expected_ratio(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg1, arg0)
        }
    }

    public fun calculate_liquidity_percent(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 == 0) {
            0
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(arg0, arg1), arg2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray())
        }
    }

    // decompiled from Move bytecode v6
}

