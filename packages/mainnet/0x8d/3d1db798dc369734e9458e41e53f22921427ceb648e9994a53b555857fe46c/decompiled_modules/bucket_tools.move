module 0x8d3d1db798dc369734e9458e41e53f22921427ceb648e9994a53b555857fe46c::bucket_tools {
    public fun get_clock(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun is_greater(arg0: u64, arg1: u64) {
        assert!(arg0 > arg1, 1);
    }

    // decompiled from Move bytecode v6
}

