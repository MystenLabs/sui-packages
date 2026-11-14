module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::oracle_guard {
    public fun assert_open<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>, arg1: u128, arg2: u128, arg3: u128) {
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::oracle<T0>(arg0);
        assert!(open_ok(arg1, arg2, arg3, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::max_twap_dev_bps(&v0)), 13835058300095299585);
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

