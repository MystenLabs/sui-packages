module 0xc49b57384fc8a5c5cf065f4e8464d3e4518f1fee2a134ce27e8bbab73f8ab006::math {
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

