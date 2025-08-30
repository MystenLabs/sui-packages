module 0xaa9fe5a82f23e64f7d1e020f0c85c13d0425650bf470bd3ffdfd89805f460733::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

