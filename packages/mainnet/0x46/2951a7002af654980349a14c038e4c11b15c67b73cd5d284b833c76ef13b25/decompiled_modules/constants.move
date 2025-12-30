module 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants {
    public fun current_version() : u64 {
        1
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, 1000000000, arg1)
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_u256() : u256 {
        (1000000000 as u256)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 1000000000)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun power_of_ten(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public fun scale_down(arg0: u64, arg1: u64) : u64 {
        mul(arg0, arg1)
    }

    public fun scale_up(arg0: u64, arg1: u64) : u64 {
        div(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

