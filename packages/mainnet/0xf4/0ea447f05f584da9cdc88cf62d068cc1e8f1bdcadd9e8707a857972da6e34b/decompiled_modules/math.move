module 0xb8f96e61eae2cb85b89605267c63d075cd029e2b3bba71c9e4ec681d0bf6ac17::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

