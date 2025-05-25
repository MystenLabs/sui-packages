module 0x76a638c4a2d8d9ac78e4d8c2910fc1c69e77af1e3969aa77e26f51eaf9e5825a::mult {
    public fun mult_128(arg0: u128, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        arg0 * arg1
    }

    public fun mult_256(arg0: u256, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        arg0 * arg1
    }

    public fun mult_u64(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        arg0 * arg1
    }

    public fun test() : u256 {
        34673429775949185766360837292402478 * 4951760157141521099596496891
    }

    // decompiled from Move bytecode v6
}

