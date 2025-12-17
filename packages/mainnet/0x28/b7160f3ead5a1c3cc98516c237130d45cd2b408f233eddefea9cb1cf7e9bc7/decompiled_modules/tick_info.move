module 0x28b7160f3ead5a1c3cc98516c237130d45cd2b408f233eddefea9cb1cf7e9bc7::tick_info {
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

