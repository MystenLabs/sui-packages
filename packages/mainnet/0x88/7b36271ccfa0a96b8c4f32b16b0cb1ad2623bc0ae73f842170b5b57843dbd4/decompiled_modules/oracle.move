module 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::oracle {
    public fun base_amount_to_usd_notional(arg0: u64, arg1: u64, arg2: u8) : u64 {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::safe_mul_div_u64(arg0, arg1, pow10(arg2))
    }

    public(friend) fun current_market_prices<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _) = usd_price_from_update(0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::base_feed_id_pro<T0, T1>(arg0), arg1, arg2, 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::base_max_age_ms<T0, T1>(arg0));
        let (v2, _) = usd_price_from_update(0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::quote_feed_id_pro<T0, T1>(arg0), arg1, arg2, 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::quote_max_age_ms<T0, T1>(arg0));
        (v0, v2, reference_price_from_usd(v0, v2, 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::base_coin_decimals<T0, T1>(arg0), 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::quote_coin_decimals<T0, T1>(arg0)))
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
        let v0 = 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::get_one_decimals();
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(arg1)) {
            let v2 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(arg1) as u8);
            if (v2 < v0) {
                arg0 * pow10(v0 - v2)
            } else if (v2 == v0) {
                arg0
            } else {
                let v3 = v2 - v0;
                assert!(v3 <= 18, 8);
                arg0 / pow10(v3)
            }
        } else {
            let v4 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(arg1) as u8) + v0;
            assert!(v4 <= 18, 8);
            arg0 * pow10(v4)
        }
    }

    fun pow10(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public fun quote_amount_to_usd_notional(arg0: u64, arg1: u64, arg2: u8) : u64 {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::safe_mul_div_u64(arg0, arg1, pow10(arg2))
    }

    public fun reference_price_from_usd(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        if (arg3 >= arg2) {
            0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::safe_mul_div_u64(arg0, 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::get_one() * pow10(arg3 - arg2), arg1)
        } else {
            0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::safe_mul_div_u64(arg0, 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::safe_math::get_one(), arg1) / pow10(arg2 - arg3)
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

