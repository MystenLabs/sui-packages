module 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

