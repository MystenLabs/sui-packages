module 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::price_feed_storage {
    public fun new_price_feed(arg0: &0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::OracleAggregatorPythIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let (v3, v4) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            let v5 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8));
            (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v5)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v5)))
        } else {
            let v6 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8));
            (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * v6), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * v6))
        };
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, arg1, arg3, 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::borrow_id(arg0), arg4, v3, v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::OracleAggregatorPythIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::borrow_id(arg0));
    }

    public fun update_price_feed(arg0: &0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::OracleAggregatorPythIntegration, arg1: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let (v3, v4) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            let v5 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8));
            (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v5)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v5)))
        } else {
            let v6 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8));
            (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * v6), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * v6))
        };
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1, arg2, 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth::borrow_id(arg0), arg3, v3, v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000);
    }

    // decompiled from Move bytecode v6
}

