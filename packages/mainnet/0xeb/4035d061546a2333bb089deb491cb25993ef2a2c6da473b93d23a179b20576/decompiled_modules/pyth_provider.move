module 0xaf203d3590bd2d223a646868f93509c45daaa4779ddb8d56b0d7fa71863ee89a::pyth_provider {
    struct PythProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_pyth_price_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_feed::PriceFeed {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let (v2, v3) = price_from_pyth_price(&v1);
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_feed::new(v2, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1), v3)
    }

    fun price_from_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v2 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8)))
        } else {
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) as u8)))
        };
        let v5 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), v2);
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&v5), 0);
        (v5, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0)), v2))
    }

    public fun update_pyth_as_primary<T0>(arg0: &0xaf203d3590bd2d223a646868f93509c45daaa4779ddb8d56b0d7fa71863ee89a::coin_registry::CoinRegistry, arg1: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg2: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::UpdatePriceRequest<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xaf203d3590bd2d223a646868f93509c45daaa4779ddb8d56b0d7fa71863ee89a::coin_registry::assert_pyth_object_info<T0>(arg0, arg4);
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::update_price_feed_as_primary<T0, PythProvider>(arg1, arg2, price_feed_from_pyth_price_info(arg4), arg3);
    }

    public fun update_pyth_as_secondary<T0>(arg0: &0xaf203d3590bd2d223a646868f93509c45daaa4779ddb8d56b0d7fa71863ee89a::coin_registry::CoinRegistry, arg1: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg2: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::UpdatePriceRequest<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xaf203d3590bd2d223a646868f93509c45daaa4779ddb8d56b0d7fa71863ee89a::coin_registry::assert_pyth_object_info<T0>(arg0, arg4);
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::update_price_feed_as_secondary<T0, PythProvider>(arg1, arg2, price_feed_from_pyth_price_info(arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

