module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::adapters_pyth {
    public fun assert_feed_fresh(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::guard::require_price_fresh(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0), 0x2::clock::timestamp_ms(arg1) / 1000, arg2);
    }

    public fun batch_needs_update(arg0: bool, arg1: u64, arg2: u64) : bool {
        0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::oracle_gate::needs_update_or(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

