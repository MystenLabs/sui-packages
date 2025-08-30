module 0xf0340fdac3dc0a919dbb92401a0be9bc4c57af49d43b0fd4fa0844c422b5a754::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

