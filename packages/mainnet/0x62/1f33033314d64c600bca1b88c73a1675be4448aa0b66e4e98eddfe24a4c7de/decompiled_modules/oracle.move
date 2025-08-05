module 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::oracle {
    public(friend) fun calculate_pyth_primitive_prices(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u8, arg4: u64, arg5: u64, arg6: u8) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::get_one_decimals();
        let (v1, v2, v3) = get_pyth_price(arg0, arg1, arg2, v0, arg4);
        (0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_u64(v1, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_u64(v2, 0x1::u64::pow(10, v0 + arg6 - arg3), arg5), 0x621f33033314d64c600bca1b88c73a1675be4448aa0b66e4e98eddfe24a4c7de::safe_math::safe_mul_div_u64(arg5, 0x1::u64::pow(10, v0 + arg3 - arg6), v1), v1, v2, v3)
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
        let (v7, v8) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            let v9 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8);
            if (v9 < arg3) {
                ((v6 + v5) * 0x1::u64::pow(10, arg3 - v9), (v6 - v5) * 0x1::u64::pow(10, arg3 - v9))
            } else {
                ((v6 + v5) / 0x1::u64::pow(10, v9 - arg3), (v6 - v5) / 0x1::u64::pow(10, v9 - arg3))
            }
        } else {
            ((v6 + v5) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + arg3), (v6 - v5) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + arg3))
        };
        (v7, v8, v5)
    }

    // decompiled from Move bytecode v6
}

