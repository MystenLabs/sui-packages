module 0xa622d01204be5d9e1b8ed45214543b6d717ff6c3bd1e0168de2ccb5fc4b15cfa::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

