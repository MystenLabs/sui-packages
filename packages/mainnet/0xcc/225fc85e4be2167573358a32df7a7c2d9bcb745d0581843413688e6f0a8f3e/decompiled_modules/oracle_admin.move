module 0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::oracle_admin {
    struct PriceDelayToleranceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        delay_ms: u64,
        who: address,
        timestamp: u64,
    }

    public fun register_pyth_feed<T0>(arg0: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::AdminCap, arg1: &mut 0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::pyth_adaptor::register_pyth_feed<T0>(0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::pyth_price_feeds_mut(arg1), arg2, arg3, arg4);
    }

    public fun update_price_delay_tolerance_ms(arg0: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::AdminCap, arg1: &mut 0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::update_price_delay_tolerance_ms(arg1, arg2);
        let v0 = PriceDelayToleranceUpdated{
            oracle    : 0x2::object::id<0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle>(arg1),
            delay_ms  : arg2,
            who       : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<PriceDelayToleranceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

