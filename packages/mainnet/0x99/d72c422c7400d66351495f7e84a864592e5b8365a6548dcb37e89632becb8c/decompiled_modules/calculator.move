module 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::calculator {
    public fun caculate_utilization(arg0: &mut 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::get_index(arg0, arg1);
        let v4 = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_div(v4, 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x2::clock::Clock, arg1: &0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::error::invalid_price());
        arg2 * (0x2::math::pow(10, v2) as u256) / v1
    }

    public fun calculate_borrow_rate(arg0: &mut 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v4, v1) + 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray()
        };
        let v0 = arg0 - 1;
        let v1 = 0;
        if (arg0 > 2) {
            v1 = arg0 - 2;
        };
        let v2 = arg1 / 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::constants::seconds_per_year();
        let v3 = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v2, v2);
        0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray() + v2 * arg0 + arg0 * v0 * v3 / 2 + arg0 * v0 * v1 * 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(v3, v2) / 6
    }

    public fun calculate_linear_interest(arg0: u256, arg1: u256) : u256 {
        0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray() + arg1 * arg0 / 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::constants::seconds_per_year()
    }

    public fun calculate_supply_rate(arg0: &mut 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::storage::get_borrow_rate_factors(arg0, arg1);
        0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0x99d72c422c7400d66351495f7e84a864592e5b8365a6548dcb37e89632becb8c::error::invalid_price());
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

