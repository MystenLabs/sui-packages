module 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

