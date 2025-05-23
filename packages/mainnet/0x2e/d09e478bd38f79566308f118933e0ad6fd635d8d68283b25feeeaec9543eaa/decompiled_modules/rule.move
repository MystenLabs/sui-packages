module 0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_adaptor::get_pyth_price(arg1, arg2, 0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::new(v5, v3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_adaptor::get_pyth_price(arg1, arg2, 0x2ed09e478bd38f79566308f118933e0ad6fd635d8d68283b25feeeaec9543eaa::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_secondary_price<T0, Rule>(v6, arg0, 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

