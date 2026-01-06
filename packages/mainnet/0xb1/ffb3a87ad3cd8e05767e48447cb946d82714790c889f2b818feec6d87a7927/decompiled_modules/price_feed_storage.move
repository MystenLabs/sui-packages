module 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::price_feed_storage {
    public fun new_price_feed(arg0: &0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: u256, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration>(arg2, arg1, arg3, 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::borrow_id(arg0), arg0, arg4, 1, arg5, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::borrow_id(arg0));
    }

    public fun update_price_feed<T0>(arg0: &0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: u256, arg5: u64) {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>(), 0);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::OracleAggregatorDevIntegration>(arg2, arg3, 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::borrow_id(arg0), arg0, arg4, 1, arg5);
    }

    // decompiled from Move bytecode v6
}

