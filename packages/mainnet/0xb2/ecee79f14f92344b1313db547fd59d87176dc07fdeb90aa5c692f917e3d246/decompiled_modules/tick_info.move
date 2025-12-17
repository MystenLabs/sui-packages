module 0xb2ecee79f14f92344b1313db547fd59d87176dc07fdeb90aa5c692f917e3d246::tick_info {
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

