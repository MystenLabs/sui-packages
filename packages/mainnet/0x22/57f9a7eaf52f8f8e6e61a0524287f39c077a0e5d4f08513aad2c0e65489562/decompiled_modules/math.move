module 0x2257f9a7eaf52f8f8e6e61a0524287f39c077a0e5d4f08513aad2c0e65489562::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

