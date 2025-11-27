module 0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_adaptor::get_pyth_price(arg1, arg2, 0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(v5, v3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_adaptor::get_pyth_price(arg1, arg2, 0xc2fd861c16bd9814ec7752e0b7d477c88176e643085cfbc50f740ef8feedeea5::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_secondary_price<T0, Rule>(v6, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

