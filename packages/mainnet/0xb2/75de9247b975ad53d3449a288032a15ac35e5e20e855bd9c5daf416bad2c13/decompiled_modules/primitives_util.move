module 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

