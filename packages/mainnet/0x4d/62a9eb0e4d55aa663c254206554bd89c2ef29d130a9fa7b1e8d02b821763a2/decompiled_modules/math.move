module 0x4d62a9eb0e4d55aa663c254206554bd89c2ef29d130a9fa7b1e8d02b821763a2::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

