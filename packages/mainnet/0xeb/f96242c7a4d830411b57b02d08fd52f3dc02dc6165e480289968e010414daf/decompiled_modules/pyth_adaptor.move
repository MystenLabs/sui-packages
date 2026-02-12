module 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::pyth_adaptor {
    struct PythFeedData has drop, store {
        feed: 0x2::object::ID,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    fun assert_price_conf_within_range(arg0: u64, arg1: u64, arg2: u64) {
        assert!(((((arg1 * 10000 * 100) as u128) / (arg0 as u128)) as u64) <= arg2 * 100, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::pyth_price_conf_too_large());
    }

    fun assert_price_not_stale(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= v1 - 30, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::pyth_price_too_old());
        assert!(v0 <= v1, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::future_pyth_price());
        v0
    }

    public(friend) fun assert_pyth_price_info_object(arg0: &PythFeedData, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == arg0.feed, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::illegal_pyth_price_object());
    }

    fun ensure_price_ok(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::pyth_price_decimals_too_large());
        assert_price_conf_within_range(v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0), arg1);
        (v1, (v3 as u8), assert_price_not_stale(arg0, arg2))
    }

    public(friend) fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &PythFeedData, arg2: &0x2::clock::Clock) : (0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::price_feed::PriceFeedComponent, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::price_feed::PriceFeedComponent) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let (v4, v5, v6) = ensure_price_ok(&v2, arg1.ema_confidence_tolerance_bps, arg2);
        let (v7, v8, v9) = ensure_price_ok(&v3, arg1.spot_confidence_tolerance_bps, arg2);
        assert!(v5 == v8, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::pyth_spot_ema_price_decimals_not_match());
        (0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::price_feed::new_component(normalize_decimals(v4, v5), v6), 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::price_feed::new_component(normalize_decimals(v7, v5), v9))
    }

    fun normalize_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::price_feed::decimals();
        let v1 = if (arg1 < v0) {
            arg0 * pow10_u64(v0 - arg1)
        } else {
            arg0 / pow10_u64(arg1 - v0)
        };
        assert!(v1 > 0, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::pyth_price_decimals_too_large());
        v1
    }

    fun pow10_u64(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            1000
        } else if (arg0 == 4) {
            10000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            10000000
        } else if (arg0 == 8) {
            100000000
        } else if (arg0 == 9) {
            1000000000
        } else if (arg0 == 10) {
            10000000000
        } else if (arg0 == 11) {
            100000000000
        } else if (arg0 == 12) {
            1000000000000
        } else if (arg0 == 13) {
            10000000000000
        } else if (arg0 == 14) {
            100000000000000
        } else if (arg0 == 15) {
            1000000000000000
        } else if (arg0 == 16) {
            10000000000000000
        } else if (arg0 == 17) {
            100000000000000000
        } else {
            assert!(arg0 == 18, 10);
            1000000000000000000
        }
    }

    public(friend) fun register_pyth_feed<T0>(arg0: &mut 0x2::table::Table<0x1::type_name::TypeName, PythFeedData>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::invalid_conf_range());
        assert!(arg3 <= 10000, 0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::oracle_error::invalid_conf_range());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PythFeedData>(arg0, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, PythFeedData>(arg0, v0);
        };
        let v1 = PythFeedData{
            feed                          : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1),
            spot_confidence_tolerance_bps : arg2,
            ema_confidence_tolerance_bps  : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, PythFeedData>(arg0, v0, v1);
    }

    // decompiled from Move bytecode v6
}

