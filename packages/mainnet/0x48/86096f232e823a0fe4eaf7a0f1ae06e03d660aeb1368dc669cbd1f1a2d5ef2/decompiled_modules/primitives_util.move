module 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

