module 0x600b953edb5a9c5da3252621d887d31c8cb3e6eeb31cff4cd8cbcb7fe0b839f7::math {
    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 / 2;
        let v1 = v0 - v0 * arg1 / 10000 + v0 - v0 * arg2 / 10000;
        if (v1 > arg0) {
            v1 - arg0
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

