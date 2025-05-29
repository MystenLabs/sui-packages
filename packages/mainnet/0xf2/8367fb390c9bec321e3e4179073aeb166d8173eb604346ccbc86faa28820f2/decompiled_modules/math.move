module 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::math {
    public fun calculate_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * 1000000000 / (arg0 as u128)) as u64)
    }

    public fun calculate_protocol_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    // decompiled from Move bytecode v6
}

