module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle_pyth {
    public(friend) fun accept_attested<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(&arg2 == 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::pyth_feed_id<T0, T1>(arg0), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_mismatch());
        assert!(arg3 > 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        assert!((arg4 as u128) * 10000 <= (arg3 as u128) * (0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::oracle_max_conf_bps(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::oracle_config(arg1)) as u128), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_confidence());
        assert!(arg5 <= 12, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        let v0 = if (arg6) {
            0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::normalize_human<T0, T1>(arg0, (arg3 as u128), (arg5 as u8))
        } else {
            let v1 = 1;
            let v2 = 0;
            while (v2 < arg5) {
                v1 = v1 * 10;
                v2 = v2 + 1;
            };
            0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::normalize_human<T0, T1>(arg0, (arg3 as u128) * v1, 0)
        };
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::accept<T0, T1>(arg0, arg1, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::source_pyth(), v0, arg7 * 1000, arg8);
    }

    public fun submit<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5)
        };
        accept_attested<T0, T1>(arg0, arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v3), v7, v6, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3), arg3);
    }

    // decompiled from Move bytecode v7
}

