module 0xf5cb872b2fea1881128e5a9435cefb176b728cac8477b27d259ed3f3ccb50197::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

