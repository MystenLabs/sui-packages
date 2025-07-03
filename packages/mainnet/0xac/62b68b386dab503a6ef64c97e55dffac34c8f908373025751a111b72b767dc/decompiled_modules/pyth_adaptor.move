module 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::pyth_adaptor {
    fun assert_price_conf_within_range(arg0: u64, arg1: u64, arg2: 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::Decimal) {
        assert!(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::le(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::div(0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(arg1), 0xfd5867a476d92de03c1b3368988754fc9f4a480dcf07bee70be465b78e88ac54::decimal::from(arg0)), arg2), 3);
    }

    fun assert_price_not_stale(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x2::clock::Clock) {
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(arg0) >= 0x2::clock::timestamp_ms(arg1) / 1000 - 30, 2);
    }

    public(friend) fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::OracleConfig, arg3: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4);
        assert!(v5 <= 255, 1);
        assert_price_not_stale(&v0, arg3);
        assert_price_conf_within_range(v2, v3, 0xac62b68b386dab503a6ef64c97e55dffac34c8f908373025751a111b72b767dc::oracle_config::price_conf_tolerance(arg2));
        (v2, v3, (v5 as u8), 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    // decompiled from Move bytecode v6
}

