module 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::pyth_adaptor {
    struct PythFeedData has drop, store {
        feed: 0x2::object::ID,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    fun assert_price_conf_within_range(arg0: u64, arg1: u64, arg2: u64) {
        assert!(((((arg1 * 10000 * 100) as u128) / (arg0 as u128)) as u64) <= arg2 * 10000 * 100 / 10000, 8000002);
    }

    fun assert_price_not_stale(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg0);
        assert!(v0 >= 0x2::clock::timestamp_ms(arg1) / 1000 - 30, 8000001);
        v0
    }

    public(friend) fun assert_pyth_price_info_object(arg0: &PythFeedData, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == arg0.feed, 70149);
    }

    fun ensure_price_ok(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 8000000);
        assert_price_conf_within_range(v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0), arg1);
        (v1, (v3 as u8), assert_price_not_stale(arg0, arg2))
    }

    public(friend) fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &PythFeedData, arg2: &0x2::clock::Clock) : (0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeedComponent, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeedComponent) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let (v4, v5, v6) = ensure_price_ok(&v2, arg1.ema_confidence_tolerance_bps, arg2);
        let (v7, v8, v9) = ensure_price_ok(&v3, arg1.spot_confidence_tolerance_bps, arg2);
        assert!(v5 == v8, 8000003);
        (0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::new_component(normalize_decimals(v4, v5), v6), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::new_component(normalize_decimals(v7, v5), v9))
    }

    fun normalize_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::decimals();
        let v1 = if (arg1 < v0) {
            arg0 * pow10_u64(v0 - arg1)
        } else {
            arg0 / pow10_u64(arg1 - v0)
        };
        assert!(v1 > 0, 8000000);
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

    public(friend) fun refresh_pyth_price<T0>(arg0: &0x2::table::Table<0x1::type_name::TypeName, PythFeedData>, arg1: &mut 0x2::table::Table<0x1::type_name::TypeName, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeed>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, PythFeedData>(arg0, v0);
        assert_pyth_price_info_object(v1, arg2);
        let (v2, v3) = get_pyth_price(arg2, v1, arg3);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeed>(arg1, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeed>(arg1, v0, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::new(v2, v3));
        } else {
            0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::set(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeed>(arg1, v0), v2, v3);
        };
    }

    public(friend) fun register_pyth_feed<T0>(arg0: &mut 0x2::table::Table<0x1::type_name::TypeName, PythFeedData>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 70151);
        assert!(arg3 <= 10000, 70151);
        let v0 = 0x1::type_name::get<T0>();
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

