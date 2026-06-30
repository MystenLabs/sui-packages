module 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::oracle {
    fun assert_price_identifier(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: vector<u8>) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == arg1, 1);
    }

    public fun base_amount_to_usd_notional(arg0: u64, arg1: u64, arg2: u8) : u64 {
        0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::safe_mul_div_u64(arg0, arg1, pow10(arg2))
    }

    public(friend) fun current_market_prices<T0, T1>(arg0: &0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::PoolState<T0, T1>, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _) = usd_price_from_update(0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_feed_id_pro<T0, T1>(arg0), arg1, arg2, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_max_age_ms<T0, T1>(arg0));
        let (v2, _) = usd_price_from_update(0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_feed_id_pro<T0, T1>(arg0), arg1, arg2, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_max_age_ms<T0, T1>(arg0));
        (v0, v2, reference_price_from_usd(v0, v2, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_coin_decimals<T0, T1>(arg0), 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_coin_decimals<T0, T1>(arg0)))
    }

    public(friend) fun current_market_prices_pyth_core<T0, T1>(arg0: &0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::PoolState<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _) = usd_price_from_pyth_core(0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_feed_id_core<T0, T1>(arg0), arg1, arg3, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_core_max_age_sec<T0, T1>(arg0));
        let (v2, _) = usd_price_from_pyth_core(0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_feed_id_core<T0, T1>(arg0), arg2, arg3, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_core_max_age_sec<T0, T1>(arg0));
        (v0, v2, reference_price_from_usd(v0, v2, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::base_coin_decimals<T0, T1>(arg0), 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::pool::quote_coin_decimals<T0, T1>(arg0)))
    }

    fun get_feed_by_id(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            let v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == arg1) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 1
    }

    fun normalize_price_to_one(arg0: u64, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u64 {
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(arg1)) {
            normalize_price_to_one_by_parts(arg0, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(arg1) as u8), true)
        } else {
            normalize_price_to_one_by_parts(arg0, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(arg1) as u8), false)
        }
    }

    fun normalize_price_to_one_by_parts(arg0: u64, arg1: u8, arg2: bool) : u64 {
        let v0 = 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::get_one_decimals();
        if (arg2) {
            if (arg1 < v0) {
                arg0 * pow10(v0 - arg1)
            } else if (arg1 == v0) {
                arg0
            } else {
                let v2 = arg1 - v0;
                assert!(v2 <= 18, 8);
                arg0 / pow10(v2)
            }
        } else {
            let v3 = arg1 + v0;
            assert!(v3 <= 18, 8);
            arg0 * pow10(v3)
        }
    }

    fun normalize_pyth_core_price_to_one(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            normalize_price_to_one_by_parts(arg0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1) as u8), true)
        } else {
            normalize_price_to_one_by_parts(arg0, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1) as u8), false)
        }
    }

    fun pow10(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public fun quote_amount_to_usd_notional(arg0: u64, arg1: u64, arg2: u8) : u64 {
        0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::safe_mul_div_u64(arg0, arg1, pow10(arg2))
    }

    public fun reference_price_from_usd(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        if (arg3 >= arg2) {
            0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::safe_mul_div_u64(arg0, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::get_one() * pow10(arg3 - arg2), arg1)
        } else {
            0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::safe_mul_div_u64(arg0, 0x606bf8932e3096a152cf6c0b055b78d7189d28faf278272bee59ed2638b29f52::safe_math::get_one(), arg1) / pow10(arg2 - arg3)
        }
    }

    fun unwrap_conf_field(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64 {
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0), 7);
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0), 7);
        0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0)
    }

    fun unwrap_i64_field(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64 {
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0), 2);
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0), 3);
        0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0)
    }

    public(friend) fun usd_price_from_pyth_core(arg0: vector<u8>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64) : (u64, u64) {
        assert_price_identifier(arg1, arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 6);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (normalize_pyth_core_price_to_one(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), &v2), normalize_pyth_core_price_to_one(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), &v2))
    }

    public(friend) fun usd_price_from_update(arg0: u32, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: u64) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg2) <= 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1) / 1000 + arg3, 5);
        let v0 = get_feed_by_id(arg1, arg0);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v1), 4);
        let v2 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v1);
        let v3 = unwrap_i64_field(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v0));
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v3), 6);
        let v4 = unwrap_conf_field(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v0));
        let v5 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v4)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_negative(&v4)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v4)
        };
        (normalize_price_to_one(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v3), &v2), normalize_price_to_one(v5, &v2))
    }

    // decompiled from Move bytecode v7
}

