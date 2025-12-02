module 0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

