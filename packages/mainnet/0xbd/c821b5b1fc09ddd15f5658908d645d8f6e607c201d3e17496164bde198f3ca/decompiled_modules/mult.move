module 0xbdc821b5b1fc09ddd15f5658908d645d8f6e607c201d3e17496164bde198f3ca::mult {
    public fun mult_128(arg0: u128, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        arg0 * arg1
    }

    public fun mult_256(arg0: u256, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        arg0 * arg1
    }

    public fun mult_u64(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        arg0 * arg1
    }

    // decompiled from Move bytecode v6
}

