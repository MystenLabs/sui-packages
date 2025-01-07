module 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::calculator {
    public fun caculate_utilization(arg0: &mut 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::get_index(arg0, arg1);
        let v4 = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_div(v4, 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 47001);
        arg2 * (0x2::math::pow(10, v2) as u256) / v1
    }

    public fun calculate_borrow_rate(arg0: &mut 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v4, v1) + 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray()
        };
        let v0 = arg0 - 1;
        let v1 = 0;
        if (arg0 > 2) {
            v1 = arg0 - 2;
        };
        let v2 = arg1 / 31536000;
        let v3 = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v2, v2);
        0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray() + v2 * arg0 + arg0 * v0 * v3 / 2 + arg0 * v0 * v1 * 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(v3, v2) / 6
    }

    public fun calculate_linear_interest(arg0: u256, arg1: u256) : u256 {
        0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray() + arg1 * arg0 / 31536000
    }

    public fun calculate_supply_rate(arg0: &mut 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::storage::get_borrow_rate_factors(arg0, arg1);
        0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0x176cf86c433a8c2bf0ecd8f6e5c26ff151fae9afdc863547256123eb96bee405::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 47001);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

