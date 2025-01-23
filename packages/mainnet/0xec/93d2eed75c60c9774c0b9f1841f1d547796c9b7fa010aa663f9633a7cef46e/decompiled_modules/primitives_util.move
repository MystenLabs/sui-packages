module 0xec93d2eed75c60c9774c0b9f1841f1d547796c9b7fa010aa663f9633a7cef46e::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

