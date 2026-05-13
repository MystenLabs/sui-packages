module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::royalty {
    public fun marketplace_fee_bps() : u64 {
        250
    }

    public fun take_fee(arg0: u64) : u64 {
        arg0 * 250 / 10000
    }

    public fun take_royalty(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

