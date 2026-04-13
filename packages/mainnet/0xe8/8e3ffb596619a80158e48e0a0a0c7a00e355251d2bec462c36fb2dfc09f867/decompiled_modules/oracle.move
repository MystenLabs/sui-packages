module 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::oracle {
    public(friend) fun calculate_pyth_primitive_prices(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u8, arg4: u64, arg5: u64, arg6: u8) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::get_one_decimals();
        let (v1, v2, v3) = get_pyth_price(arg0, arg1, arg2, v0, arg4);
        (0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(v1, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(v2, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(arg5, 0x1::u64::pow(10, v0 + arg3 - arg6), v1), v1, v2, v3)
    }

    public(friend) fun calculate_pyth_primitive_prices_pro(arg0: u32, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: u8, arg4: u64, arg5: u64, arg6: u8) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::get_one_decimals();
        let (v1, v2, v3) = get_pyth_price_pro(arg0, arg1, arg2, v0, arg4);
        (0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(v1, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(v2, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0xfd6098ae62cbfc3803d8a6fc560e05c412840bf2a2afffa41c0acf2db4434bbd::safe_math::safe_mul_div_u64(arg5, 0x1::u64::pow(10, v0 + arg3 - arg6), v1), v1, v2, v3)
    }

    fun get_feed_by_id_pro(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            let v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == arg1) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 3
    }

    fun get_pyth_price(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u8, arg4: u64) : (u64, u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg1, arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(arg0 == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v6 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
        };
        assert!(v6 != 0, 2);
        let v7 = v5 / 2;
        let (v8, v9) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            let v10 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8);
            if (v10 < arg3) {
                let v11 = 0x1::u64::pow(10, arg3 - v10);
                ((v6 + v7) * v11, (v6 - v7) * v11)
            } else if (v10 == arg3) {
                (v6 + v7, v6 - v7)
            } else {
                let v12 = v10 - arg3;
                assert!(v12 <= 18, 11);
                let v13 = 0x1::u64::pow(10, v12);
                ((v6 + v7) / v13, (v6 - v7) / v13)
            }
        } else {
            ((v6 + v7) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + arg3), (v6 - v7) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + arg3))
        };
        (v8, v9, v5)
    }

    fun get_pyth_price_pro(arg0: u32, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock, arg3: u8, arg4: u64) : (u64, u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg2) <= 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1) / 1000 + arg4 * 1000, 10);
        let v0 = get_feed_by_id_pro(arg1, arg0);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v1), 6);
        let v2 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v1);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v2), 7);
        let v3 = unwrap_i64_field(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v0), 4, 5);
        let v4 = unwrap_i64_field(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v0), 8, 9);
        let v5 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v3)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_negative(&v3)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v3)
        };
        assert!(v5 != 0, 2);
        let v6 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v4)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_negative(&v4)
        } else {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v4)
        };
        let v7 = v6 / 2;
        let v8 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v2) as u8);
        let (v9, v10) = if (v8 < arg3) {
            let v11 = 0x1::u64::pow(10, arg3 - v8);
            ((v5 + v7) * v11, (v5 - v7) * v11)
        } else if (v8 == arg3) {
            (v5 + v7, v5 - v7)
        } else {
            let v12 = v8 - arg3;
            assert!(v12 <= 18, 11);
            let v13 = 0x1::u64::pow(10, v12);
            ((v5 + v7) / v13, (v5 - v7) / v13)
        };
        (v9, v10, v6)
    }

    fun unwrap_i64_field(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg1: u64, arg2: u64) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64 {
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0), arg1);
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0), arg2);
        0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0)
    }

    // decompiled from Move bytecode v7
}

