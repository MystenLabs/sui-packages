module 0x3dbfa4eb85cab08eebec7d3fa563e39f126b5c16490a734ce964e9c4f2c4d9ab::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

