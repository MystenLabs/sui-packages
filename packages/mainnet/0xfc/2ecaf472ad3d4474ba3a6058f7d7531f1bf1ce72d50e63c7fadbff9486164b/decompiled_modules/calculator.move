module 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::calculator {
    public fun caculate_utilization(arg0: &mut 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::get_index(arg0, arg1);
        let v4 = 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_div(v4, 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x2::clock::Clock, arg1: &0xccdf4385016f20c784e68376359ddc2f6a9e050ec431ca5c85f1bc81024d4427::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xccdf4385016f20c784e68376359ddc2f6a9e050ec431ca5c85f1bc81024d4427::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 47001);
        arg2 * (0x2::math::pow(10, v2) as u256) / v1
    }

    public fun calculate_borrow_rate(arg0: &mut 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v5, v1) + 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        let v0 = ((arg0 - arg1) as u256) / 1000;
        if (v0 == 0) {
            return 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = 0;
        if (v0 > 2) {
            v2 = v0 - 2;
        };
        let v3 = arg2 / 31536000;
        let v4 = 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v3, v3);
        0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray() + 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v3, v0) + v0 * v1 * v4 / 2 + v0 * v1 * v2 * 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(v4, v3) / 6
    }

    public fun calculate_linear_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray() + arg2 * ((arg0 - arg1) as u256) / 1000 / 31536000
    }

    public fun calculate_supply_rate(arg0: &mut 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0x266772afbc66047204d9b784884e40f29fbe05cef6f386f2d473e574e2c4c1c1::storage::get_borrow_rate_factors(arg0, arg1);
        0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0x8964495a5989638a5c6f5ece2badd55d78226b2d6b3398d7a3bf0d92a987e8d0::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xccdf4385016f20c784e68376359ddc2f6a9e050ec431ca5c85f1bc81024d4427::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xccdf4385016f20c784e68376359ddc2f6a9e050ec431ca5c85f1bc81024d4427::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 47001);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

