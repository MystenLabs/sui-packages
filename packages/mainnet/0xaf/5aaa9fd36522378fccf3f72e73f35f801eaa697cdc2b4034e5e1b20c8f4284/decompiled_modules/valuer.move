module 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::valuer {
    struct PythValuerWitness has drop {
        dummy_field: bool,
    }

    public fun answer_feed_challenge<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg3));
        let v0 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::borrow_feed<T1>(arg3);
        assert!(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_feed_id(arg4) == 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(&v0), 1525);
        let v1 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::answer_feed_challenge<T0, T1, PythValuerWitness>(v1, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_published_ms(arg4), arg5);
    }

    public fun quote<T0, T1>(arg0: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::QuoteBook, arg2: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg3: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg4: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg4));
        let (v0, v1, v2, v3) = price<T1, T0>(arg4, arg5, arg6, arg7);
        let v4 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::quote<T0, T1, PythValuerWitness>(v4, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2, arg3, v0, v1, v2, v3, arg7);
    }

    public fun record_asset_support<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg3));
        let v0 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::borrow_feed<T1>(arg3);
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::assert_not_scheduled_for_removal(&v0);
        let (v1, _, _, _) = price<T1, T0>(arg3, arg4, arg5, arg6);
        assert!(v1 >= 10000, 1529);
        let (_, _, _, _) = price_with_headroom<T1, T0>(arg3, arg4, arg5, arg6, 4);
        let v9 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::record_asset_support<T0, T1, PythValuerWitness>(v9, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2);
    }

    public fun report_feed_unreadable<T0, T1: store, T2>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg4: 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::PositionKey, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg3));
        let (v0, v1) = feed_evidence<T2>(arg3, arg5, arg6);
        let v2 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_feed_unreadable<T0, T1, T2, PythValuerWitness>(v2, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2, arg4, v0, v1, arg6, arg7)
    }

    public fun report_idle_unreadable<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg3));
        let (v0, v1) = feed_evidence<T1>(arg3, arg4, arg5);
        let v2 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::report_idle_unreadable<T0, T1, PythValuerWitness>(v2, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2, v0, v1, arg5, arg6)
    }

    public fun revoke_asset_support<T0, T1>(arg0: &mut 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::Strategy<T0>, arg1: &0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::ValuerInfo, arg2: &0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist::WhitelistRegistry, arg3: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::allowed_versions(arg3));
        let v0 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::feed<T1>(arg3);
        assert!(0x1::option::is_none<0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig>(&v0) || 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_removal_due_ms(0x1::option::borrow<0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig>(&v0)) != 0, 1530);
        let v1 = PythValuerWitness{dummy_field: false};
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::revoke_asset_support<T0, T1, PythValuerWitness>(v1, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), arg0, arg1, arg2);
    }

    fun assert_confidence(arg0: &0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, arg1: u16) {
        assert!(0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::within_confidence(arg0, (arg1 as u64)), 1527);
    }

    fun feed_evidence<T0>(arg0: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u8, u64) {
        let v0 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::feed<T0>(arg0);
        if (0x1::option::is_none<0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig>(&v0)) {
            return (0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_feed_unregistered(), 0)
        };
        assert!(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_feed_id(arg1) == 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(0x1::option::borrow<0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig>(&v0)), 1525);
        let v1 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_published_ms(arg1);
        assert!(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::is_dead(v1, 0x2::clock::timestamp_ms(arg2)), 1528);
        (0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy::reason_feed_dead(), v1)
    }

    public fun price<T0, T1>(arg0: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u128, u128, u128, u64) {
        price_with_headroom<T0, T1>(arg0, arg1, arg2, arg3, 0)
    }

    fun price_with_headroom<T0, T1>(arg0: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: u8) : (u128, u128, u128, u64) {
        let v0 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::borrow_feed<T0>(arg0);
        let v1 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::borrow_feed<T1>(arg0);
        assert!(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_feed_id(arg1) == 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(&v0), 1525);
        assert!(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::pio_feed_id(arg2) == 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(&v1), 1526);
        let v2 = 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::max_price_age_secs();
        let (v3, v4) = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::pyth_reader::get_validated_price_and_ema_with_age(arg1, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(&v0), arg3, v2);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::pyth_reader::get_validated_price_and_ema_with_age(arg2, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_feed_id(&v1), arg3, v2);
        let v9 = v8;
        let v10 = v7;
        scaled_price(&v0, &v1, &v6, &v5, &v10, &v9, arg4)
    }

    fun scaled_price(arg0: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig, arg1: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedConfig, arg2: &0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, arg3: &0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, arg4: &0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, arg5: &0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, arg6: u8) : (u128, u128, u128, u64) {
        assert_confidence(arg2, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_max_confidence_bps(arg0));
        assert_confidence(arg4, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_max_confidence_bps(arg1));
        let v0 = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::with_confidence_capped(arg3, (0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_max_confidence_bps(arg0) as u64));
        let v1 = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::with_confidence_capped(arg5, (0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_max_confidence_bps(arg1) as u64));
        let (v2, v3, v4) = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::scaled_quote(arg2, &v0, arg4, &v1, 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_decimals(arg0), 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::config_decimals(arg1) + arg6);
        let v5 = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validated_price_timestamp(arg2);
        let v6 = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validated_price_timestamp(arg4);
        let v7 = if (v5 < v6) {
            v5
        } else {
            v6
        };
        (v2, v3, v4, v7 * 1000)
    }

    public fun unreadable_reason<T0>(arg0: &0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry::FeedRegistry, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u8 {
        let (v0, _) = feed_evidence<T0>(arg0, arg1, arg2);
        v0
    }

    // decompiled from Move bytecode v7
}

