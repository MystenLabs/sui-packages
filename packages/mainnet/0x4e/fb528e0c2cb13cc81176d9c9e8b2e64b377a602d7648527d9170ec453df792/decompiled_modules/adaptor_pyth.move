module 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::adaptor_pyth {
    fun load_price_components(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : (u64, bool, u32) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0), 1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0);
        assert!(v1 > 0, 2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2);
        let v4 = if (v3) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2)
        };
        (v1, v3, (v4 as u32))
    }

    fun normalize_to_wad(arg0: u64, arg1: bool, arg2: u32) : u128 {
        assert!(arg2 <= 38, 3);
        let v0 = (arg0 as u128);
        let v1 = 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::oracle_math::pow10(arg2);
        if (arg1) {
            0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::oracle_math::mul_div_down(v0, 1000000000000000000, v1)
        } else {
            assert!(v1 <= 340282366920938463463 / v0, 3);
            0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::oracle_math::mul_checked(0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::oracle_math::mul_checked(v0, v1), 1000000000000000000)
        }
    }

    public fun update_price<T0>(arg0: &mut 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 1000);
        let (v1, v2, v3) = load_price_components(&v0);
        0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::update_price<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg0, 0x1::type_name::with_defining_ids<T0>(), 1, normalize_to_wad(v1, v2, v3), normalize_to_wad(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0), v2, v3), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

