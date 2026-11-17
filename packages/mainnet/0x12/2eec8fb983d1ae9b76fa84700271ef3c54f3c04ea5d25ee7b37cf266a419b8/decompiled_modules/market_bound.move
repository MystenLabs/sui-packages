module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound {
    struct MarketBound<phantom T0, phantom T1> has drop, store {
        oracle: 0x2::object::ID,
        feed_in: u8,
        feed_out: u8,
        decimals_in: u8,
        decimals_out: u8,
        max_deviation_bps: u64,
    }

    public(friend) fun assert_oracle<T0, T1>(arg0: &MarketBound<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.oracle == arg1, 2);
    }

    public(friend) fun check<T0, T1>(arg0: &MarketBound<T0, T1>, arg1: u64, arg2: u64, arg3: u256, arg4: u8, arg5: u256, arg6: u8) {
        let v0 = arg0.decimals_in + arg4;
        let v1 = arg0.decimals_out + arg6;
        let v2 = 0x1::u8::max(v0, v1);
        assert!((arg2 as u256) * arg5 * 0x1::u256::pow(10, v2 - v1) * 10000 >= (arg1 as u256) * arg3 * 0x1::u256::pow(10, v2 - v0) * (10000 - (arg0.max_deviation_bps as u256)), 0);
    }

    public fun decimals_in<T0, T1>(arg0: &MarketBound<T0, T1>) : u8 {
        arg0.decimals_in
    }

    public fun decimals_out<T0, T1>(arg0: &MarketBound<T0, T1>) : u8 {
        arg0.decimals_out
    }

    public fun feed_in<T0, T1>(arg0: &MarketBound<T0, T1>) : u8 {
        arg0.feed_in
    }

    public fun feed_out<T0, T1>(arg0: &MarketBound<T0, T1>) : u8 {
        arg0.feed_out
    }

    public fun max_deviation_bps<T0, T1>(arg0: &MarketBound<T0, T1>) : u64 {
        arg0.max_deviation_bps
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u64) : MarketBound<T0, T1> {
        assert!((arg5 as u256) < 10000, 1);
        MarketBound<T0, T1>{
            oracle            : arg0,
            feed_in           : arg1,
            feed_out          : arg2,
            decimals_in       : arg3,
            decimals_out      : arg4,
            max_deviation_bps : arg5,
        }
    }

    public fun oracle<T0, T1>(arg0: &MarketBound<T0, T1>) : 0x2::object::ID {
        arg0.oracle
    }

    // decompiled from Move bytecode v7
}

