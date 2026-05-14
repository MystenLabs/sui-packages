module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::pyth_nav {
    public fun mark_nav_from_pyth_single_feed<T0, T1>(arg0: &mut 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg3, arg4, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 30);
        let v2 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3);
        let v5 = if (v4) {
            (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u128)
        } else {
            (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u128)
        };
        if (v2 > 0) {
            assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) as u128) * 10000 / v2 <= (50 as u128), 32);
        };
        let v6 = if (v4) {
            ((v2 * 1000000 / pow10(v5)) as u64)
        } else {
            ((v2 * pow10(v5) * 1000000) as u64)
        };
        assert!(v6 >= 1000 && v6 <= 100000000000, 31);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault::set_nav<T0, T1>(arg0, arg1, arg2, v6, arg4);
    }

    fun pow10(arg0: u128) : u128 {
        let v0 = 1;
        let v1 = 0;
        let v2 = if (arg0 > 18) {
            18
        } else {
            arg0
        };
        while (v1 < v2) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

