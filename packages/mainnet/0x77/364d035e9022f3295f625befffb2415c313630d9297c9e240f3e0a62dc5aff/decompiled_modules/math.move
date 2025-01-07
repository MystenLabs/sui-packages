module 0x77364d035e9022f3295f625befffb2415c313630d9297c9e240f3e0a62dc5aff::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

