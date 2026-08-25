module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle_pyth {
    public fun submit<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
        assert!(&v3 == 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::pyth_feed_id<T0, T1>(arg0), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_mismatch());
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v4);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5);
        assert!(v6 > 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v4) as u128) * 10000 <= (v6 as u128) * (0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::oracle_max_conf_bps(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::oracle_config(arg1)) as u128), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_confidence());
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v4);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v7);
        let v9 = if (v8) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v7)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v7)
        };
        assert!(v9 <= 12, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        let v10 = if (v8) {
            0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::normalize_human<T0, T1>(arg0, (v6 as u128), (v9 as u8))
        } else {
            let v11 = 1;
            let v12 = 0;
            while (v12 < v9) {
                v11 = v11 * 10;
                v12 = v12 + 1;
            };
            0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::normalize_human<T0, T1>(arg0, (v6 as u128) * v11, 0)
        };
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::accept<T0, T1>(arg0, arg1, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::source_pyth(), v10, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v4) * 1000, arg3);
    }

    // decompiled from Move bytecode v7
}

