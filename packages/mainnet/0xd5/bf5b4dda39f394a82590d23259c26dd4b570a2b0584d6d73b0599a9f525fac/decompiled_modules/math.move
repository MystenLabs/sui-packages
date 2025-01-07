module 0xd5bf5b4dda39f394a82590d23259c26dd4b570a2b0584d6d73b0599a9f525fac::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

