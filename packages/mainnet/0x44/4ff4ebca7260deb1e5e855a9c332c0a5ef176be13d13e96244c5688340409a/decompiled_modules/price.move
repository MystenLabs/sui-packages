module 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::price {
    public fun add_spread<T0>(arg0: &0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::Config, arg1: u64) : u64 {
        let v0 = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_spread<T0>(arg0);
        let v1 = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 + take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::curve::curve(0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_k_scaled(arg0), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v1), true)))
        } else {
            arg1 + take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::curve::curve(0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_k_scaled(arg0), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v1), true)))
        }
    }

    public fun ask_price<T0>(arg0: &0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, _) = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::oracle::get_price(arg0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_registry_price_id<T0>(arg0), arg1, arg2);
        let v3 = v1;
        let v4 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4) == false, 0);
        (add_spread<T0>(arg0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v4)), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v3))
    }

    public fun bid_price<T0>(arg0: &0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, _) = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::oracle::get_price(arg0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_registry_price_id<T0>(arg0), arg1, arg2);
        let v3 = v1;
        let v4 = v0;
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4) == false, 1);
        (sub_spread<T0>(arg0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v4)), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v3))
    }

    public fun sub_spread<T0>(arg0: &0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::Config, arg1: u64) : u64 {
        let v0 = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_spread<T0>(arg0);
        let v1 = 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_current_count(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            arg1 - take_percent_base_18(arg1, v0) + take_percent_base_18(arg1, take_percent_base_18(v0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::curve::curve(0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_k_scaled(arg0), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v1), true)))
        } else {
            arg1 - take_percent_base_18(arg1, v0) - take_percent_base_18(arg1, take_percent_base_18(v0, 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::curve::curve(0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_k_scaled(arg0), 0x444ff4ebca7260deb1e5e855a9c332c0a5ef176be13d13e96244c5688340409a::config::get_magnitude(&v1), true)))
        }
    }

    public fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

