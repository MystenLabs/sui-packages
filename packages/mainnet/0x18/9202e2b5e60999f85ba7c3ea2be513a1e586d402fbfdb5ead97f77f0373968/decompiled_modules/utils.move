module 0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::utils {
    fun is_valid_time<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg0 + arg1 <= timestamp_sec(arg2)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

