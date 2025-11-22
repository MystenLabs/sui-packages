module 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

