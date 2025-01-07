module 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

