module 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::oracle_pyth {
    public fun needs_update(arg0: bool, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64) : bool {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::oracle_gate::needs_update(arg0, price_ts_secs(arg1), 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::oracle_gate::now_secs(arg2), arg3)
    }

    public fun price_ts_secs(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0)
    }

    public fun require_fresh<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::freshness::FreshnessTicket {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::freshness::check_pyth<T0>(arg0, arg1, arg2)
    }

    public fun stub_verify_once_update(arg0: bool) {
        abort 200
    }

    // decompiled from Move bytecode v7
}

