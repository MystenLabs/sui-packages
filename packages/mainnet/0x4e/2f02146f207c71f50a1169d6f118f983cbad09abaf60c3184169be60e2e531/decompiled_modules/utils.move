module 0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::utils {
    fun is_valid_time<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg0 + arg1 <= timestamp_sec(arg2)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

