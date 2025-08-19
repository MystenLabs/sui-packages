module 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::fast_price_feed {
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

    public fun get_amount_from_price_feed(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        assert!(arg3 > 0, 2);
        let (v0, v1) = get_price(arg0, arg1, arg2, arg4);
        (v0, v1, safe_mul(v1, arg3) / pow10((arg1 as u8)))
    }

    public fun get_amount_from_price_feed_v2(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        assert!(arg4 > 0, 2);
        let (v0, v1) = get_price(arg0, arg1, arg3, arg5);
        (v0, v1, safe_mul(safe_mul(v1, arg4) / pow10((arg1 as u8)), pow10((arg2 as u8))) / pow10((arg1 as u8)))
    }

    public fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u8>, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg3, arg2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4);
        let v6 = if (v5) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
        };
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7);
        let v9 = PriceFeedEvent{
            price_feed_id : v2,
            price         : v8,
            expo          : v6,
        };
        0x2::event::emit<PriceFeedEvent>(v9);
        let v10 = if (v5) {
            if (arg1 >= v6) {
                scale_price(v8, arg1 - v6, true)
            } else {
                scale_price(v8, v6 - arg1, false)
            }
        } else {
            scale_price(v8, arg1 + v6, true)
        };
        (v2, v10)
    }

    public fun pow10(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
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

    public entry fun test_get_amount_from_price_feed(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = get_amount_from_price_feed(arg0, arg1, arg2, arg3, arg4);
        let v3 = PriceFeedAmountEvent{
            price_feed_id          : v0,
            price                  : v1,
            amount_in_target_token : v2,
        };
        0x2::event::emit<PriceFeedAmountEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

