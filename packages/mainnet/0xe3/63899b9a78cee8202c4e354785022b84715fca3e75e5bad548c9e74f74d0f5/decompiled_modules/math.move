module 0xe363899b9a78cee8202c4e354785022b84715fca3e75e5bad548c9e74f74d0f5::math {
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

