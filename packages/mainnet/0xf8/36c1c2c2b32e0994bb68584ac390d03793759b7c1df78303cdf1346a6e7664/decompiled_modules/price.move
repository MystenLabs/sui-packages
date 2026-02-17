module 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::price {
    fun normalize(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        let v0 = 6;
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1);
            if (v2 <= (v0 as u64)) {
                arg0 * pow10((v0 as u64) - v2)
            } else {
                arg0 / pow10(v2 - (v0 as u64))
            }
        } else {
            arg0 * pow10((v0 as u64) + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1))
        }
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = &arg0;
        if (*v0 == 0) {
            1
        } else if (*v0 == 1) {
            10
        } else if (*v0 == 2) {
            100
        } else if (*v0 == 3) {
            1000
        } else if (*v0 == 4) {
            10000
        } else if (*v0 == 5) {
            100000
        } else if (*v0 == 6) {
            1000000
        } else if (*v0 == 7) {
            10000000
        } else if (*v0 == 8) {
            100000000
        } else if (*v0 == 9) {
            1000000000
        } else if (*v0 == 10) {
            10000000000
        } else if (*v0 == 11) {
            100000000000
        } else {
            assert!(*v0 == 12, 1000000);
            1000000000000
        }
    }

    public(friend) fun read_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &vector<u8>, arg2: u64, arg3: u8) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == *arg1, 24);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000;
        let v4 = 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::config::oracle_tolerance_ms(arg3);
        let v5 = if (arg2 > v4) {
            arg2 - v4
        } else {
            0
        };
        assert!(v3 >= v5 && v3 <= arg2 + v4, 26);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v6), 25);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        normalize(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), &v7)
    }

    // decompiled from Move bytecode v6
}

