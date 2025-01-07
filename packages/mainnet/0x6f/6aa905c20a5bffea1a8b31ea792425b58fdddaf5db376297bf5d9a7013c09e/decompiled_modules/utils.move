module 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::utils {
    public fun get_remain_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            0
        } else if (arg3 <= arg1) {
            arg0
        } else {
            mul_div(arg0, arg2 - arg3, arg2 - arg1)
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

