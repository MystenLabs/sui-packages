module 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::calculator {
    public fun caculate_utilization(arg0: &mut 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::get_index(arg0, arg1);
        let v4 = 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_div(v4, 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x68db1615c477d48f8c27b69466947a476800fd674e4904d61a2619b1a88a8f50::oracle::PriceOracle, arg1: u256, arg2: u8) : u256 {
        let (v0, v1) = 0x68db1615c477d48f8c27b69466947a476800fd674e4904d61a2619b1a88a8f50::oracle::get_token_price(arg0, arg2);
        arg1 * (0x2::math::pow(10, v1) as u256) / v0
    }

    public fun calculate_borrow_rate(arg0: &mut 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v5, v1) + 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        let v0 = ((arg0 - arg1) as u256) / 1000;
        if (v0 == 0) {
            return 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = 0;
        if (v0 > 2) {
            v2 = v0 - 2;
        };
        let v3 = arg2 / 31536000;
        let v4 = 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v3, v3);
        0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray() + 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v3, v0) + v0 * v1 * v4 / 2 + v0 * v1 * v2 * 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(v4, v3) / 6
    }

    public fun calculate_linear_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray() + arg2 * ((arg0 - arg1) as u256) / 1000 / 31536000
    }

    public fun calculate_supply_rate(arg0: &mut 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0xe496bf641e223c43f88efc5e5aa632c3a85ca02f10f8a221e484bed21fdae655::storage::get_borrow_rate_factors(arg0, arg1);
        0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0x7c4d5f703e9a8bc26bbe8a4db7515f6682ac4da0b2e5c81497dc745ecf61485e::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x68db1615c477d48f8c27b69466947a476800fd674e4904d61a2619b1a88a8f50::oracle::PriceOracle, arg1: u256, arg2: u8) : u256 {
        let (v0, v1) = 0x68db1615c477d48f8c27b69466947a476800fd674e4904d61a2619b1a88a8f50::oracle::get_token_price(arg0, arg2);
        arg1 * v0 / (0x2::math::pow(10, v1) as u256)
    }

    // decompiled from Move bytecode v6
}

