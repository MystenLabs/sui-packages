module 0x66cfa8e4dc9dd8db2ca64e20a79c4d08b2bc1ab17bc99568c2467f292465e235::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

