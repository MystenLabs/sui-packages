module 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness {
    struct FreshnessTicket has drop {
        feed_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        max_age_secs: u64,
    }

    public fun asset(arg0: &FreshnessTicket) : 0x1::type_name::TypeName {
        arg0.asset
    }

    public fun check_pyth<T0>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : FreshnessTicket {
        let v0 = 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg1);
        assert!(v0 == 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::require_feed<T0>(arg0), 120);
        let v1 = 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::max_price_age_secs(arg0);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::oracle_gate::require_fresh(price_ts_secs(arg1), arg2, v1);
        mint_ticket<T0>(v0, v1)
    }

    public fun consume_for<T0>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: FreshnessTicket) {
        assert!(arg1.feed_id == 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::require_feed<T0>(arg0), 120);
        assert!(arg1.asset == 0x1::type_name::with_defining_ids<T0>(), 121);
        let FreshnessTicket {
            feed_id      : _,
            asset        : _,
            max_age_secs : _,
        } = arg1;
    }

    public fun consume_pair<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: FreshnessTicket, arg2: FreshnessTicket) {
        consume_for<T0>(arg0, arg1);
        consume_for<T1>(arg0, arg2);
    }

    public fun e_asset_mismatch() : u64 {
        121
    }

    public fun e_feed_mismatch() : u64 {
        120
    }

    public fun feed_id(arg0: &FreshnessTicket) : 0x2::object::ID {
        arg0.feed_id
    }

    public fun max_age_secs(arg0: &FreshnessTicket) : u64 {
        arg0.max_age_secs
    }

    fun mint_ticket<T0>(arg0: 0x2::object::ID, arg1: u64) : FreshnessTicket {
        FreshnessTicket{
            feed_id      : arg0,
            asset        : 0x1::type_name::with_defining_ids<T0>(),
            max_age_secs : arg1,
        }
    }

    fun price_ts_secs(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0)
    }

    // decompiled from Move bytecode v7
}

