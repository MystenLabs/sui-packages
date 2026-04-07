module 0x2537724f692fc7e241139203b9180872007aae8a7aae2cf533bdbc3f6b2808b::price_feed {
    public fun compute_pair_price(arg0: u128, arg1: bool, arg2: u64, arg3: u128, arg4: bool, arg5: u64) : u128 {
        let (v0, v1) = signed_sub(arg1, arg2, arg4, arg5);
        if (!v0) {
            arg0 * 1000000000000000000 * pow10(v1) / arg3
        } else {
            arg0 * 1000000000000000000 / arg3 * pow10(v1)
        }
    }

    public fun extract_pair_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64) : u128 {
        let (v0, v1, v2) = get_feed_price(arg0, arg2, arg3);
        let (v3, v4, v5) = get_feed_price(arg1, arg2, arg3);
        compute_pair_price(v0, v1, v2, v3, v4, v5)
    }

    public fun get_feed_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64) : (u128, bool, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 13906834393386713089);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        assert!(v2 > 0, 13906834401976778755);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3);
        let v5 = if (v4) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        ((v2 as u128), v4, v5)
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_precision() : u128 {
        1000000000000000000
    }

    fun signed_add(arg0: bool, arg1: u64, arg2: bool, arg3: u64) : (bool, u64) {
        if (arg0 == arg2) {
            (arg0, arg1 + arg3)
        } else if (arg1 >= arg3) {
            let v2 = arg1 - arg3;
            let v3 = v2 == 0 && false || arg0;
            (v3, v2)
        } else {
            let v4 = arg3 - arg1;
            let v5 = v4 == 0 && false || arg2;
            (v5, v4)
        }
    }

    fun signed_sub(arg0: bool, arg1: u64, arg2: bool, arg3: u64) : (bool, u64) {
        let v0 = arg3 == 0 && false || !arg2;
        signed_add(arg0, arg1, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

