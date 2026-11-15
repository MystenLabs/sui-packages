module 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::oracle_guard {
    public fun assert_open<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>, arg1: u128, arg2: u128, arg3: u128) {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle<T0>(arg0);
        assert!(open_ok(arg1, arg2, arg3, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_twap_dev_bps(&v0) % 1000000), 13835058317275168769);
    }

    public fun close_band_bps<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::Market<T0>) : u64 {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::oracle<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::market::max_twap_dev_bps(&v0) / 1000000
    }

    public fun min_band_bps() : u64 {
        100
    }

    public fun open_ok(arg0: u128, arg1: u128, arg2: u128, arg3: u64) : bool {
        if (arg3 < 100) {
            return true
        };
        let v0 = (arg0 as u256);
        let v1 = (arg2 as u256);
        let v2 = (arg3 as u256);
        let v3 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        v3 * 10000 <= v2 * v1 && (arg1 as u256) * 10000 <= v2 * v0
    }

    // decompiled from Move bytecode v7
}

