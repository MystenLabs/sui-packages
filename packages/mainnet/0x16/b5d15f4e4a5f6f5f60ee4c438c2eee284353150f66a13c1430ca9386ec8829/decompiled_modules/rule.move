module 0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_adaptor::get_pyth_price(arg1, arg2, 0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(v5, v3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_adaptor::get_pyth_price(arg1, arg2, 0x16b5d15f4e4a5f6f5f60ee4c438c2eee284353150f66a13c1430ca9386ec8829::pyth_registry::pyth_feed_data(arg3, 0x1::type_name::get<T0>()), arg4);
        let v4 = 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x1::u64::pow(10, v4 - v2)
        } else {
            v0 / 0x1::u64::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_secondary_price<T0, Rule>(v6, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

