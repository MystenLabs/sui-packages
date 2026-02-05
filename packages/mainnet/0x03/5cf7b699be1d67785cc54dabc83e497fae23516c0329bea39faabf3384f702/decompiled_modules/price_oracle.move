module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::price_oracle {
    fun bytes_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun compute_usd_micro(arg0: u128, arg1: u8, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg2), 5);
        let v0 = (arg0 as u256) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg2) as u256) * (1000000 as u256);
        let v1 = v0;
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg3);
        let v3 = if (v2) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg3)
        };
        assert!(v3 <= (38 as u64), 6);
        let v4 = (v3 as u8);
        if (!v2) {
            v1 = v0 * pow10_u256(v4);
        };
        let v5 = pow10_u256(arg1);
        let v6 = v5;
        if (v2) {
            v6 = v5 * pow10_u256(v4);
        };
        let v7 = 0x1::u256::try_as_u64(v1 / v6);
        assert!(0x1::option::is_some<u64>(&v7), 8);
        0x1::option::destroy_some<u64>(v7)
    }

    public fun e_exponent_too_large() : u64 {
        6
    }

    public fun e_feed_id_mismatch() : u64 {
        9
    }

    public fun e_invalid_feed_id() : u64 {
        2
    }

    public fun e_negative_price() : u64 {
        5
    }

    public fun e_price_not_found() : u64 {
        3
    }

    public fun e_price_stale() : u64 {
        7
    }

    public fun e_value_overflow() : u64 {
        8
    }

    public fun e_zero_amount() : u64 {
        1
    }

    fun enforce_freshness(arg0: &0x2::clock::Clock, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) {
        if (arg1 == 0) {
            return
        };
        let v0 = seconds_to_millis(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg2));
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(v1 >= v0, 7);
        assert!(v1 - v0 <= arg1, 7);
    }

    fun ensure_feed_matches(arg0: &vector<u8>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v0);
        assert!(bytes_equal(arg0, &v1), 9);
    }

    fun pow10_u256(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < (arg0 as u64)) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote_usd<T0>(arg0: u128, arg1: u8, arg2: vector<u8>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 2);
        assert!(arg1 <= 38, 6);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        ensure_feed_matches(&arg2, &v0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        enforce_freshness(arg4, arg5, &v1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        compute_usd_micro(arg0, arg1, &v2, &v3)
    }

    fun seconds_to_millis(arg0: u64) : u64 {
        arg0 * 1000
    }

    // decompiled from Move bytecode v6
}

