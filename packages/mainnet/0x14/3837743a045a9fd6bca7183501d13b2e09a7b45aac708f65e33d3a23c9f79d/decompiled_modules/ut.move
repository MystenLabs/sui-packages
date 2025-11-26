module 0x143837743a045a9fd6bca7183501d13b2e09a7b45aac708f65e33d3a23c9f79d::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

