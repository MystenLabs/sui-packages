module 0x42ea6c70122dda5982b3c0fe5a2cc9a80894bf438ee4bccc9c3c1b4bd3601f41::tick_info {
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

