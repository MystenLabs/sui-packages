module 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pyth_lazer {
    fun extract_ema_price(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : 0x1::option::Option<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal> {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(arg0);
        if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0)) {
            let v1 = *0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0);
            if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1)) {
                let v2 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1);
                if (!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v2)) {
                    let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2);
                    if (v3 > 0) {
                        return 0x1::option::some<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal>(from_lazer_price(v3, arg1))
                    };
                };
            };
        };
        0x1::option::none<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal>()
    }

    fun from_lazer_price(arg0: u64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal {
        let v0 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1) as u64)
        } else {
            (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) as u64)
        };
        let v1 = 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::new((arg0 as u128), v0, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1));
        assert!(0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::base(&v1) > 0, 3);
        v1
    }

    public(friend) fun get_prices(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u64, arg2: u32, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal, 0x1::option::Option<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::oracle_decimal::OracleDecimal>, u64, u64) {
        let v0 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0), arg1);
        assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v0) == arg2, 2);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg0) / 1000000;
        let v2 = 0x2::clock::timestamp_ms(arg5) / 1000;
        if (v2 > v1 && v2 - v1 > arg3) {
            abort 1
        };
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v0);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v3), 5);
        let v4 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v3);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v0);
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v5), 4);
        let v6 = *0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v5);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v6), 4);
        let v7 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v6);
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v7), 7);
        let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v7);
        assert!(v8 > 0, 3);
        let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v0);
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v9), 6);
        let v10 = *0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v9);
        let v11 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v10)) {
            let v12 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v10);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v12)) {
                0
            } else {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v12)
            }
        } else {
            0
        };
        assert!((v11 as u128) * 100 <= (v8 as u128) * (arg4 as u128), 0);
        (from_lazer_price(v8, v4), extract_ema_price(v0, v4), v11, v8)
    }

    // decompiled from Move bytecode v6
}

