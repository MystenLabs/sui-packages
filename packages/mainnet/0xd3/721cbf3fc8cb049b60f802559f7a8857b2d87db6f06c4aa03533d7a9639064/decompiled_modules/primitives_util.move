module 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

