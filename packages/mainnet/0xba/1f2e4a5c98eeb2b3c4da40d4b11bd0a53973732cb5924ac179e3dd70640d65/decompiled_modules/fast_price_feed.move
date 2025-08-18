module 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed {
    public fun get_amount_from_price_feed(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (vector<u8>, u64, u64) {
        assert!(arg3 > 0, 2);
        let (v0, v1) = get_price(arg0, arg1, arg2, arg4);
        (v0, v1, safe_mul(v1, arg3) / pow10((arg1 as u8)))
    }

    public fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u8>, u64) {
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
        let v7 = if (v4) {
            if (arg1 >= v5) {
                scale_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), arg1 - v5, true)
            } else {
                scale_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), v5 - arg1, false)
            }
        } else {
            scale_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), arg1 + v5, true)
        };
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), v7)
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

    // decompiled from Move bytecode v6
}

