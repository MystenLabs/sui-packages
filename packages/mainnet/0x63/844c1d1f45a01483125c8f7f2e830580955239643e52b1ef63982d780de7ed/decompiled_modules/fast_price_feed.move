module 0xffb7c9726224597e54606958ada3fad60bf7dc5cecc238ff97af99304ee75228::fast_price_feed {
    struct PriceFeedAmountEvent has copy, drop, store {
        price_feed_id: vector<u8>,
        price: u64,
        amount_in_target_token: u64,
    }

    struct PriceFeedEvent has copy, drop, store {
        price_feed_id: vector<u8>,
        price: u64,
        expo: u64,
    }

    public fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u8>, u64) {
        assert!(arg1 <= 18, 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg3, arg2);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3);
        let v5 = if (v4) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6), 3);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6);
        assert!(v7 > 0, 4);
        let v8 = if (v4) {
            if (arg1 >= v5) {
                scale_price(v7, arg1 - v5, true)
            } else {
                scale_price(v7, v5 - arg1, false)
            }
        } else {
            scale_price(v7, arg1 + v5, true)
        };
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), v8)
    }

    public fun get_amount_with_price_feed(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        let (v0, v1) = get_price(arg0, arg1, arg3, arg5);
        let v2 = pow10((arg1 as u8));
        (v0, v1, safe_mul_div_u64(safe_mul_div_u64(v1, arg4, v2), pow10((arg2 as u8)), v2))
    }

    public fun get_amount_with_price_feed_guarded(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        let (v0, v1) = get_price_guarded(arg0, arg1, arg3, arg4, arg6);
        let v2 = pow10((arg1 as u8));
        (v0, v1, safe_mul_div_u64(safe_mul_div_u64(v1, arg5, v2), pow10((arg2 as u8)), v2))
    }

    public fun get_price_guarded(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (vector<u8>, u64) {
        assert!(arg1 <= 18, 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg4, arg2);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3);
        let v5 = if (v4) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6), 3);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6);
        assert!(v7 > 0, 4);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2) as u128) * (10000 as u128) <= (v7 as u128) * (arg3 as u128), 5);
        let v8 = if (v4) {
            if (arg1 >= v5) {
                scale_price(v7, arg1 - v5, true)
            } else {
                scale_price(v7, v5 - arg1, false)
            }
        } else {
            scale_price(v7, arg1 + v5, true)
        };
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), v8)
    }

    public fun pow10(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun scale_price(arg0: u64, arg1: u64, arg2: bool) : u64 {
        assert!(arg1 <= 18, 1);
        if (arg2) {
            safe_mul(arg0, pow10((arg1 as u8)))
        } else {
            arg0 / pow10((arg1 as u8))
        }
    }

    public entry fun test_get_amount_with_price_feed(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1, v2) = get_amount_with_price_feed(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = PriceFeedAmountEvent{
            price_feed_id          : v0,
            price                  : v1,
            amount_in_target_token : v2,
        };
        0x2::event::emit<PriceFeedAmountEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

