module 0x6e90255ea0e268b1d4caf4bf4f08c9c5dedfd7739ace62dbbc9610ad3498e9f6::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

