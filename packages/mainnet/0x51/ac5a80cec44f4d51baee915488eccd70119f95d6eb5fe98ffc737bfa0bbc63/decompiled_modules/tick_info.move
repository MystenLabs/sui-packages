module 0x51ac5a80cec44f4d51baee915488eccd70119f95d6eb5fe98ffc737bfa0bbc63::tick_info {
    struct TickInfo has copy, drop, store {
        index: u32,
        liquidity_gross: u128,
        liquidity_net: u128,
    }

    public fun new(arg0: u32, arg1: u128, arg2: u128) : TickInfo {
        TickInfo{
            index           : arg0,
            liquidity_gross : arg1,
            liquidity_net   : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

