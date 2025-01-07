module 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::calculator {
    public fun caculate_utilization(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (v0, v1) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_total_supply(arg0, arg1);
        let (_, v3) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_index(arg0, arg1);
        let v4 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v1, v3);
        if (v4 + arg2 == 0) {
            0
        } else {
            0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(v1, v0 - v4 + v4)
        }
    }

    public fun calculate_borrow_rate(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: u256) : u256 {
        let (v0, v1, v2, _, v4) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_borrow_rate_factors(arg0, arg1);
        let v5 = caculate_utilization(arg0, arg1, arg2);
        if (v5 < v4) {
            v0 + 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v5, v1)
        } else {
            v0 + 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v5, v1) + 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v5 - v4, v2)
        }
    }

    public fun calculate_compounded_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        let v0 = ((arg0 - arg1) as u256);
        if (v0 == 0) {
            return 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray()
        };
        let v1 = v0 - 1;
        let v2 = 0;
        if (v0 > 2) {
            v2 = v0 - 2;
        };
        let v3 = arg2 / 31536000;
        let v4 = 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v3, v3);
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray() + v3 * v0 + v0 * v1 * v4 / 2 + v0 * v1 * v2 * 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_mul(v4, v3) / 6
    }

    public fun calculate_linear_interest(arg0: u64, arg1: u64, arg2: u256) : u256 {
        0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray() + arg2 * ((arg0 - arg1) as u256) / 31536000
    }

    public fun calculate_repay_amount(arg0: &0x2::clock::Clock, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8, arg3: u256, arg4: u256) : u256 {
        arg3 * calculate_borrow_rate(arg1, arg2, arg3) * ((0x2::clock::timestamp_ms(arg0) as u256) - arg4) / 31536000
    }

    public fun calculate_supply_rate(arg0: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg1: u8, arg2: u256, arg3: u256) : u256 {
        let (_, _, _, v3, _) = 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::get_borrow_rate_factors(arg0, arg1);
        arg2 * caculate_utilization(arg0, arg1, arg3) * (0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray() - v3)
    }

    public fun calculate_value(arg0: &0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::PriceOracle, arg1: u256, arg2: u8) : u256 {
        let (v0, v1) = 0xa4951e331eab16415301bc6e4c297cd7e369c3a19871373fb9f8dc92275f77e7::oracle::get_token_price(arg0, arg2);
        arg1 * v0 / (0x2::math::pow(10, v1) as u256)
    }

    public fun calculate_withdraw_amount(arg0: &0x2::clock::Clock, arg1: &mut 0x6ad9ac7b4f2a8b6fb2449e4fcae8dc650a6c81488690e4db51cc076f280055c::storage::Storage, arg2: u8, arg3: u256, arg4: u256) : u256 {
        let v0 = calculate_borrow_rate(arg1, arg2, arg3);
        arg3 * calculate_supply_rate(arg1, arg2, v0, arg3) * ((0x2::clock::timestamp_ms(arg0) as u256) - arg4) / 31536000
    }

    // decompiled from Move bytecode v6
}

