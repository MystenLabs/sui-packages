module 0xafc115051cc86f2380aafdaffa461a1461ea0669035d8635a6cc5dcf2b11ef64::math {
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

