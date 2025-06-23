module 0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::uint_convert {
    public(friend) fun to_u256(arg0: u64) : u256 {
        (arg0 as u256)
    }

    public(friend) fun to_u64(arg0: u256) : u64 {
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

