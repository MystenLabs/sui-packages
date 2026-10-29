module 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::oracle_gate {
    public fun needs_update(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0) {
            return true
        };
        if (arg1 > arg2) {
            return true
        };
        arg2 - arg1 > arg3
    }

    public fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun require_fresh(arg0: u64, arg1: &0x2::clock::Clock, arg2: u64) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_price_fresh(arg0, now_secs(arg1), arg2);
    }

    public fun require_tx_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

