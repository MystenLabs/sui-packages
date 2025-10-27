module 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::price_feed_storage {
    public fun new_price_feed(arg0: &0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::OracleAggregatorPythIntegration, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::AuthorityCap<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::PACKAGE, 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::ADMIN>, arg2: &mut 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8))))
        } else {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8)))
        };
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::new_price_feed<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::ADMIN, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, arg1, arg3, 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::borrow_id(arg0), arg4, v3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::OracleAggregatorPythIntegration, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::AuthorityCap<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::PACKAGE, T0>, arg2: &mut 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg3: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config) {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::borrow_id(arg0));
    }

    public fun update_price_feed(arg0: &0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::OracleAggregatorPythIntegration, arg1: &mut 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg2: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)), 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8))))
        } else {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8)))
        };
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::update_price_feed<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1, arg2, 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::borrow_id(arg0), arg3, v3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000);
    }

    // decompiled from Move bytecode v6
}

