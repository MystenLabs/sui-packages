module 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::float_scaling_u128() / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::float_scaling_u128()) as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

