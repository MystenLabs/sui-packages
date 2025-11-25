module 0xfe671bdf212e1a1499528345529b7648736ba8dafd80dace7ca1643f04c26340::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

