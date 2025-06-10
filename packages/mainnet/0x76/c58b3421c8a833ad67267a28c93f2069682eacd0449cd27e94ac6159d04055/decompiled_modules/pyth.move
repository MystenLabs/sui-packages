module 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::pyth {
    fun from_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0)) {
            0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::div(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v0) as u8)))
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) as u8)) * 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::float_scaling()
        }
    }

    public fun get_price(arg0: &0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::OracleConfig, arg1: &mut 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::OracleHolder, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::assert_version(arg0);
        assert!(0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::oracle_type(arg0) == 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::oracle_type_pyth(), 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::oracle_id(arg0) == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), 0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v3);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v3);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v4);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v4);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v4) as u128) * (0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::max_bps() as u128) <= (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7) as u128) * (0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::max_confidence_interval_bps(arg0) as u128), 3);
        assert!(v6 + 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::max_staleness_threshold_s(arg0) >= 0x2::clock::timestamp_ms(arg3) / 1000, 2);
        0x2::vec_map::insert<0x2::object::ID, 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::PriceFeed>(0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::price_feeds_mut(arg1), 0x2::object::id<0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::OracleConfig>(arg0), 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::new_price_feed(from_pyth_price(&v4), 0x1::option::some<u64>(from_pyth_price(&v5)), v6));
    }

    public fun new_oracle(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        0x2::transfer::public_share_object<0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::OracleConfig>(0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::new_config(arg1, arg2, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), 0x76c58b3421c8a833ad67267a28c93f2069682eacd0449cd27e94ac6159d04055::oracle::oracle_type_pyth(), arg4));
    }

    // decompiled from Move bytecode v6
}

