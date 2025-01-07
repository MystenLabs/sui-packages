module 0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::utils {
    fun is_valid_time<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg0 + arg1 <= timestamp_sec(arg2)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

