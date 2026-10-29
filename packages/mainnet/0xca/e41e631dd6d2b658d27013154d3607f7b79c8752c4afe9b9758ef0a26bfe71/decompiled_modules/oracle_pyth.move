module 0xcae41e631dd6d2b658d27013154d3607f7b79c8752c4afe9b9758ef0a26bfe71::oracle_pyth {
    public fun needs_update(arg0: bool, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64) : bool {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::oracle_gate::needs_update(arg0, price_ts_secs(arg1), 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::oracle_gate::now_secs(arg2), arg3)
    }

    public fun price_ts_secs(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0)
    }

    public fun require_fresh<T0>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::check_pyth<T0>(arg0, arg1, arg2)
    }

    public fun stub_verify_once_update(arg0: bool) {
        abort 200
    }

    // decompiled from Move bytecode v7
}

