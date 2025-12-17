module 0x9af35fbeabc4ba1167ebbbe4afae40d1377a28af58a9bf6ab42c8374dc2f3f8f::tick_info {
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

