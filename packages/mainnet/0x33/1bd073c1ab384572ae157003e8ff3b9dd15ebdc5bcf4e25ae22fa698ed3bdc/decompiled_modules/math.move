module 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

