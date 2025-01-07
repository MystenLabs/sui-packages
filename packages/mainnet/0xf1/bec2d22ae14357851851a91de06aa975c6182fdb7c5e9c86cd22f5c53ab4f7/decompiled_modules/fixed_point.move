module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point {
    public fun decode(arg0: u256) : u64 {
        ((arg0 / 18446744073709551615) as u64)
    }

    public fun encode(arg0: u64) : u256 {
        (arg0 as u256) * 18446744073709551615
    }

    public fun uqdiv(arg0: u256, arg1: u64) : u256 {
        arg0 / (arg1 as u256)
    }

    // decompiled from Move bytecode v6
}

