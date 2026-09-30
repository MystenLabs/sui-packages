module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::pyth_core {
    fun assert_feed(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo, arg1: vector<u8>) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(arg0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v0) == arg1, 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_wrong_feed());
    }

    public(friend) fun read_source(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: vector<u8>, arg2: bool, arg3: &0x2::clock::Clock) : 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Price {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        assert_feed(&v0, arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        let v2 = reading_error(&v1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_arrival_time(&v0), arg2, arg3);
        if (0x1::option::is_some<u64>(&v2)) {
            abort 0x1::option::destroy_some<u64>(v2)
        };
        to_price(&v1)
    }

    fun reading_error(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(arg0);
        if (v0 < v1) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_too_old())
        };
        let v2 = if (arg2) {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::max_age_liquidate()
        } else {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::max_age_operate()
        };
        if (v0 - v1 > v2) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_too_old())
        };
        if (arg1 > v1 + 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::max_pyth_arrival_lag()) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_arrived_too_late())
        };
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(arg0);
        if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3)) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_not_valid())
        };
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v3);
        if (v4 == 0) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_not_valid())
        };
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(arg0);
        if (!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5)) {
            if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5) != 0) {
                return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_not_valid())
            };
        } else if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5) > 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::max_pyth_exponent()) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_price_not_valid())
        };
        let v6 = if (arg2) {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::confidence_scale_factor_liquidate()
        } else {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::constants::confidence_scale_factor_operate()
        };
        if ((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(arg0) as u128) * v6 > (v4 as u128)) {
            return 0x1::option::some<u64>(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::pyth_core_confidence_not_sufficient())
        };
        0x1::option::none<u64>()
    }

    fun to_price(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Price {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(arg0);
        let v2 = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v1)) {
            (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v1) as u32)
        } else {
            0
        };
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::new_price((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0) as u128), 0x1::option::some<u32>(v2))
    }

    public(friend) fun try_read_source(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: vector<u8>, arg2: &0x2::clock::Clock) : (0x1::option::Option<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Price>, u64) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        assert_feed(&v0, arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        let v2 = reading_error(&v1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_arrival_time(&v0), true, arg2);
        if (0x1::option::is_some<u64>(&v2)) {
            return (0x1::option::none<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Price>(), 0x1::option::destroy_some<u64>(v2))
        };
        (0x1::option::some<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Price>(to_price(&v1)), 0)
    }

    // decompiled from Move bytecode v7
}

