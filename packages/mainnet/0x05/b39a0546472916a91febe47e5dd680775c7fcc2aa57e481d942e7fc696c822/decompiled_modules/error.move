module 0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::error {
    public fun invalid_input_type() : u64 {
        2
    }

    public fun invalid_pool_id() : u64 {
        1
    }

    public fun invalid_repay_type() : u64 {
        3
    }

    public fun slippage_exceeded() : u64 {
        4
    }

    // decompiled from Move bytecode v6
}

