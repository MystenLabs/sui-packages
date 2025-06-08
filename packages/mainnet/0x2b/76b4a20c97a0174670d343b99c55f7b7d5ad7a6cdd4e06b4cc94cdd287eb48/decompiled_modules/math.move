module 0x2b76b4a20c97a0174670d343b99c55f7b7d5ad7a6cdd4e06b4cc94cdd287eb48::math {
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

