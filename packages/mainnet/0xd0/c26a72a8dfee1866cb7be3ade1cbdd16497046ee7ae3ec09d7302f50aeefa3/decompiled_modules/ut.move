module 0xd0c26a72a8dfee1866cb7be3ade1cbdd16497046ee7ae3ec09d7302f50aeefa3::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

