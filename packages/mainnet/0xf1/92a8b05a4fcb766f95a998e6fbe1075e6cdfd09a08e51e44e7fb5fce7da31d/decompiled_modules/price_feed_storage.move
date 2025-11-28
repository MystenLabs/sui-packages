module 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::price_feed_storage {
    public fun new_price_feed(arg0: &0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::OracleAggregatorPythIntegration, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>, arg2: &mut 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let (v3, v4) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            let v5 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8));
            (0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(v5)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(v5)))
        } else {
            let v6 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8));
            (0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * v6), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * v6))
        };
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::new_price_feed<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, arg1, arg3, 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::borrow_id(arg0), arg4, v3, v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::OracleAggregatorPythIntegration, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, T0>, arg2: &mut 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg3: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config) {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::borrow_id(arg0));
    }

    public fun update_price_feed(arg0: &0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::OracleAggregatorPythIntegration, arg1: &mut 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg2: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let (v3, v4) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            let v5 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8));
            (0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(v5)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(v5)))
        } else {
            let v6 = 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8));
            (0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * v6), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * v6))
        };
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::update_price_feed<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1, arg2, 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::borrow_id(arg0), arg3, v3, v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000);
    }

    // decompiled from Move bytecode v6
}

