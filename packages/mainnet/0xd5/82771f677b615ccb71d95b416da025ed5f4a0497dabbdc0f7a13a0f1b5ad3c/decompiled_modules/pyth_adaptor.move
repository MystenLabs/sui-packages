module 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor {
    struct PythFeedData has drop, store {
        feed: 0x2::object::ID,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    struct PythProFeedInfo has drop, store {
        feed_id: u32,
        expected_channel_id: u8,
        min_publisher_count: u16,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
        last_updated_timestamp_us: u64,
    }

    public(friend) fun assert_channel_matches(arg0: &PythProFeedInfo, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2::Channel) {
        let v0 = arg0.expected_channel_id;
        let v1 = &v0;
        let v2 = 1;
        let v3 = if (v1 == &v2) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2::is_real_time(arg1)
        } else {
            let v4 = 2;
            if (v1 == &v4) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2::is_fixed_rate_50ms(arg1)
            } else {
                let v5 = 3;
                if (v1 == &v5) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2::is_fixed_rate_200ms(arg1)
                } else {
                    let v6 = 4;
                    v1 == &v6 && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::channel_v2::is_fixed_rate_1000ms(arg1)
                }
            }
        };
        assert!(v3, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_unexpected_channel());
    }

    fun ensure_feed_timestamp_ok(arg0: u64, arg1: &PythProFeedInfo, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) * 1000;
        assert!(arg0 <= v0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::future_pyth_price());
        assert!(arg0 + 30000000 >= v0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_price_too_old());
        assert!(arg0 >= arg1.last_updated_timestamp_us, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_price_too_old());
    }

    fun ensure_price_conf_within_range(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::oracle_zero_price_error());
        assert!((((arg1 as u128) * (10000 as u128) * 100 / (arg0 as u128)) as u64) <= arg2 * 100, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_price_conf_too_large());
    }

    public(friend) fun expected_channel_id(arg0: &PythProFeedInfo) : u8 {
        arg0.expected_channel_id
    }

    fun extract_from_nested_optional<T0: drop>(arg0: 0x1::option::Option<0x1::option::Option<T0>>, arg1: u64) : T0 {
        assert!(0x1::option::is_some<0x1::option::Option<T0>>(&arg0), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_missing_item() + arg1);
        let v0 = 0x1::option::extract<0x1::option::Option<T0>>(&mut arg0);
        assert!(0x1::option::is_some<T0>(&v0), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_no_value() + arg1);
        0x1::option::extract<T0>(&mut v0)
    }

    public(friend) fun feed_id(arg0: &PythProFeedInfo) : u32 {
        arg0.feed_id
    }

    fun is_known_channel_id(arg0: u8) : bool {
        let v0 = &arg0;
        let v1 = 1;
        if (v0 == &v1) {
            true
        } else {
            let v3 = 2;
            if (v0 == &v3) {
                true
            } else {
                let v4 = 3;
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = 4;
                    v0 == &v5
                }
            }
        }
    }

    fun normalize_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::decimals();
        let v1 = if (arg1 < v0) {
            arg0 * pow10_u64(v0 - arg1)
        } else {
            arg0 / pow10_u64(arg1 - v0)
        };
        assert!(v1 > 0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_price_decimals_too_large());
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

    public(friend) fun refresh_pyth_price(arg0: &mut PythProFeedInfo, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg2: &0x2::clock::Clock) : (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent) {
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(arg1) == arg0.feed_id, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_feed_id_not_matching());
        refresh_pyth_price_inner(arg0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::publisher_count(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_confidence(arg1), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg1), arg2)
    }

    fun refresh_pyth_price_inner(arg0: &mut PythProFeedInfo, arg1: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>, arg2: 0x1::option::Option<u16>, arg3: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg4: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg5: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg6: 0x1::option::Option<0x1::option::Option<u64>>, arg7: 0x1::option::Option<0x1::option::Option<u64>>, arg8: &0x2::clock::Clock) : (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent) {
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_missing_item() + 0);
        let v0 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut arg1);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v0);
        assert!(v1 <= 255, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_price_decimals_too_large());
        let v2 = (v1 as u8);
        assert!(0x1::option::is_some<u16>(&arg2), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_missing_item() + 1);
        assert!(0x1::option::extract<u16>(&mut arg2) >= arg0.min_publisher_count, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_publisher_count_too_small());
        let v3 = extract_from_nested_optional<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(arg3, 2);
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v3);
        let v5 = extract_from_nested_optional<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(arg4, 3);
        ensure_price_conf_within_range(v4, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v5), arg0.spot_confidence_tolerance_bps);
        let v6 = extract_from_nested_optional<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(arg5, 4);
        let v7 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v6);
        ensure_price_conf_within_range(v7, extract_from_nested_optional<u64>(arg6, 5), arg0.ema_confidence_tolerance_bps);
        let v8 = extract_from_nested_optional<u64>(arg7, 6);
        ensure_feed_timestamp_ok(v8, arg0, arg8);
        arg0.last_updated_timestamp_us = v8;
        let v9 = v8 / 1000000;
        (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new_component(normalize_decimals(v7, v2), v9), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new_component(normalize_decimals(v4, v2), v9))
    }

    public(friend) fun register_pyth_feed<T0>(arg0: &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<PythProFeedInfo>, arg1: u32, arg2: u8, arg3: u16, arg4: u64, arg5: u64) {
        assert!(arg3 != 0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_invalid_min_publisher_count());
        assert!(arg4 <= 10000, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::invalid_conf_range());
        assert!(arg5 <= 10000, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::invalid_conf_range());
        assert!(is_known_channel_id(arg2), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::pyth_pro_unexpected_channel());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<PythProFeedInfo>(arg0, v0)) {
            let v1 = PythProFeedInfo{
                feed_id                       : arg1,
                expected_channel_id           : arg2,
                min_publisher_count           : arg3,
                spot_confidence_tolerance_bps : arg4,
                ema_confidence_tolerance_bps  : arg5,
                last_updated_timestamp_us     : 0,
            };
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::set<PythProFeedInfo>(arg0, v0, v1);
        } else {
            let v2 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow_mut<PythProFeedInfo>(arg0, v0);
            v2.feed_id = arg1;
            v2.expected_channel_id = arg2;
            v2.min_publisher_count = arg3;
            v2.spot_confidence_tolerance_bps = arg4;
            v2.ema_confidence_tolerance_bps = arg5;
        };
    }

    // decompiled from Move bytecode v7
}

