module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates {
    public fun calculate_average_liquidity(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(arg0 - arg1, 86400);
        (arg2 * (86400 - v0) + arg3 * v0) / 86400
    }

    public fun calculate_borrow_rate(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u256) : u256 {
        let v0 = calculate_utilization(arg0, arg1, arg2);
        let (v1, v2, v3, v4) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate_factors(arg0, arg1);
        if (v0 < v4) {
            v1 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v0, v2)
        } else {
            v1 + v2 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0 - v4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - v4))
        }
    }

    public fun calculate_compounded_interest(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 - arg1;
        if (v0 == 0) {
            return 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = if (v0 > 2) {
            v0 - 2
        } else {
            0
        };
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg2, arg2) / 31536000 * 31536000;
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() + arg2 * v0 / 31536000 + v0 * v1 * v3 / 2 + v0 * v1 * v2 * 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3, arg2) / 31536000 / 6
    }

    public fun calculate_linear_interest(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() + arg2 * (arg0 - arg1) / 31536000
    }

    public fun calculate_liquidity_rate(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u256, arg3: u256) : u256 {
        let v0 = calculate_utilization(arg0, arg1, arg3);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray() - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_treasury_factor(arg0, arg1)))
    }

    public fun calculate_utilization(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u256) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_dtoken_scaled_total_supply(arg0, arg1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index(arg0, arg1));
        if (v0 + arg2 == 0) {
            0
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0, v0 + arg2)
        }
    }

    // decompiled from Move bytecode v6
}

