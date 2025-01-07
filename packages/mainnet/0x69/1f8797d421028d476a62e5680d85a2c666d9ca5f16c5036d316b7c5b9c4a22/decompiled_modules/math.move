module 0x691f8797d421028d476a62e5680d85a2c666d9ca5f16c5036d316b7c5b9c4a22::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

