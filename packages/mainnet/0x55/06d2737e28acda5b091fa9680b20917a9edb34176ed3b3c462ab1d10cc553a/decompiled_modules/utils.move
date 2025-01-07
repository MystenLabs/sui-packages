module 0x2844f6bcf1c2054175cc92627ec74426a890a8a4f6f2c50f8304d34b0aadf12::utils {
    public fun ceil_div(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    public fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

