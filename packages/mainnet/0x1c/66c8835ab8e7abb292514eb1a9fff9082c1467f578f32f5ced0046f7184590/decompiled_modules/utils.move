module 0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::utils {
    fun is_valid_time<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg0 + arg1 <= timestamp_sec(arg2)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

