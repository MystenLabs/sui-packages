module 0xa3bd218544ffadc43649045661240cd4d3a29cb7e69a89e738cbb7e82767fb36::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

