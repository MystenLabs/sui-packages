module 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::pyth_adaptor {
    struct PythFeedData has drop, store {
        feed: 0x2::object::ID,
        conf_tolerance: u64,
    }

    fun assert_price_conf_within_range(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = 10000;
        assert!(((((arg1 * v0 * 100) as u128) / (arg0 as u128)) as u64) <= arg2 * v0 * 100 / 10000, 70297);
    }

    fun assert_price_not_stale(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x2::clock::Clock) {
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg0) >= 0x2::clock::timestamp_ms(arg1) / 1000 - 30, 70146);
    }

    fun assert_pyth_price_info_object(arg0: &PythFeedData, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == arg0.feed, 70149);
    }

    fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &PythFeedData, arg3: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4);
        assert!(v5 <= 255, 70145);
        assert_price_not_stale(&v0, arg3);
        assert_price_conf_within_range(v2, v3, arg2.conf_tolerance);
        (v2, v3, (v5 as u8), 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    public fun pow10_u64(arg0: u8) : u64 {
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
            assert!(arg0 == 18, 0);
            1000000000000000000
        }
    }

    public(friend) fun refresh_pyth_price<T0>(arg0: &0x2::table::Table<0x1::type_name::TypeName, PythFeedData>, arg1: &mut 0x2::table::Table<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, PythFeedData>(arg0, v0);
        assert_pyth_price_info_object(v1, arg3);
        let (v2, _, v4, v5) = get_pyth_price(arg2, arg3, v1, arg4);
        let v6 = 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::decimals();
        let v7 = if (v4 < v6) {
            v2 * pow10_u64(v6 - v4)
        } else {
            v2 / pow10_u64(v4 - v6)
        };
        assert!(v7 > 0, 70145);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>(arg1, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>(arg1, v0, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::new(v7, v5));
        } else {
            0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::update(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>(arg1, v0), v7, v5);
        };
    }

    public(friend) fun register_pyth_feed<T0>(arg0: &mut 0x2::table::Table<0x1::type_name::TypeName, PythFeedData>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) {
        assert!(arg2 <= 10000, 70151);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PythFeedData>(arg0, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, PythFeedData>(arg0, v0);
        };
        let v1 = PythFeedData{
            feed           : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1),
            conf_tolerance : arg2,
        };
        0x2::table::add<0x1::type_name::TypeName, PythFeedData>(arg0, v0, v1);
    }

    // decompiled from Move bytecode v6
}

