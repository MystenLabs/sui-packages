module 0x29c377ea819a181abf7d71e5592f7c6f82bd7c647ef0a33bf38033c4514fcf5::pyth_adaptor {
    fun assert_price_conf_within_range(arg0: u64, arg1: u64) {
        let v0 = 10000;
        assert!(((((arg1 * v0 * 100) as u128) / (arg0 as u128)) as u64) <= 2 * v0, 70297);
    }

    fun assert_price_not_stale(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x2::clock::Clock) {
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg0) >= 0x2::clock::timestamp_ms(arg1) / 1000 - 10, 70146);
    }

    public fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4);
        assert!(v5 <= 255, 70145);
        assert_price_not_stale(&v0, arg2);
        assert_price_conf_within_range(v2, v3);
        (v2, v3, (v5 as u8), 0x2::clock::timestamp_ms(arg2) / 1000)
    }

    // decompiled from Move bytecode v6
}

