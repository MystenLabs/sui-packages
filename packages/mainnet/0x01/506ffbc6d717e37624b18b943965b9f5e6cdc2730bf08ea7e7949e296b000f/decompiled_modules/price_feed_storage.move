module 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::price_feed_storage {
    public fun new_price_feed(arg0: &0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>, arg2: &mut 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: u256, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::new_price_feed<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN, 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration>(arg2, arg1, arg3, 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::borrow_id(arg0), arg0, arg4, 1, arg5, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg2: &mut 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::borrow_id(arg0));
    }

    public fun update_price_feed<T0>(arg0: &0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg2: &mut 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: u256, arg5: u64) {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>(), 0);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::update_price_feed<0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration>(arg2, arg3, 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::borrow_id(arg0), arg0, arg4, 1, arg5);
    }

    // decompiled from Move bytecode v6
}

