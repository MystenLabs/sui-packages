module 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::calculator {
    public fun caculate_utilization(arg0: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_index(arg0, arg1);
        let v4 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_div(v4, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::error::invalid_price());
        arg2 * (0x2::math::pow(10, v2) as u256) / v1
    }

    public fun calculate_borrow_rate(arg0: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v4, v1) + 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray()
        };
        let v0 = arg0 - 1;
        let v1 = 0;
        if (arg0 > 2) {
            v1 = arg0 - 2;
        };
        let v2 = arg1 / 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::constants::seconds_per_year();
        let v3 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v2, v2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray() + v2 * arg0 + arg0 * v0 * v3 / 2 + arg0 * v0 * v1 * 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(v3, v2) / 6
    }

    public fun calculate_linear_interest(arg0: u256, arg1: u256) : u256 {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray() + arg1 * arg0 / 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::constants::seconds_per_year()
    }

    public fun calculate_supply_rate(arg0: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_borrow_rate_factors(arg0, arg1);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::error::invalid_price());
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

