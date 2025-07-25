module 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::calculator {
    public fun caculate_utilization(arg0: &mut 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::Storage, arg1: u8) : u256 {
        let (v0, v1) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_index(arg0, arg1);
        let v4 = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v1, v3);
        if (v4 == 0) {
            0
        } else {
            0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_div(v4, 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v0, v2))
        }
    }

    public fun calculate_amount(arg0: &0x2::clock::Clock, arg1: &0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::error::invalid_price());
        arg2 * (0x2::math::pow(10, v2) as u256) / v1
    }

    public fun calculate_borrow_rate(arg0: &mut 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::Storage, arg1: u8) : u256 {
        let (v0, v1, v2, _, v4) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1);
        if (v5 < v4) {
            v0 + 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v4, v1) + 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray()
        };
        let v0 = arg0 - 1;
        let v1 = 0;
        if (arg0 > 2) {
            v1 = arg0 - 2;
        };
        let v2 = arg1 / 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::constants::seconds_per_year();
        let v3 = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v2, v2);
        0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray() + v2 * arg0 + arg0 * v0 * v3 / 2 + arg0 * v0 * v1 * 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(v3, v2) / 6
    }

    public fun calculate_linear_interest(arg0: u256, arg1: u256) : u256 {
        0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray() + arg1 * arg0 / 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::constants::seconds_per_year()
    }

    public fun calculate_supply_rate(arg0: &mut 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (_, _, _, v3, _) = 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::storage::get_borrow_rate_factors(arg0, arg1);
        0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray_mul(arg2, caculate_utilization(arg0, arg1)), 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (v0, v1, v2) = 0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::get_token_price(arg0, arg1, arg3);
        assert!(v0, 0xd60882fdcda18bf76d4fd25fef955ac1af88f6fb36984171c972b6dd12f5c700::error::invalid_price());
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

