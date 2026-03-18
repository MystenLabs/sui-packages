module 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::user_oracle {
    fun check_price(arg0: &0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal {
        let v0 = 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::value(arg0);
        assert!(v0 > 0, 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::update_time(arg0) * 1000 <= arg1, 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::oracle_error::oracle_stale_price_error());
        0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::from_quotient(v0, 0x1::u64::pow(10, 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal {
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::ensure_version_matches(arg0);
        check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::ema(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price(arg0, arg1, arg2)), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal) : 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal {
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::ema(v0), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::spot(v0), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::gt(v1, v2)) {
            0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::div(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::sub(v1, v2), v2)
        } else {
            0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::div(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::sub(v2, v1), v2)
        };
        assert!(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::le(v3, arg4), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal {
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::ensure_version_matches(arg0);
        check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::spot(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price(arg0, arg1, arg2)), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_spot_price_with_check(arg0: &0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal) : 0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::Decimal {
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::ema(v0), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::price_feed::spot(v0), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::gt(v1, v2)) {
            0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::div(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::sub(v1, v2), v1)
        } else {
            0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::div(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::sub(v2, v1), v1)
        };
        assert!(0x66b17dfda9979bd426d342953e20fae77e0eaaf773d5fe44978bd61e50282062::float::le(v3, arg4), 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::ensure_version_matches(arg0);
        0xdf4e8ea4fcca84e88d2325b4d89af8b815c59c6ed5af45697baeeee5ff5353d::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

