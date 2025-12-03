module 0xc8e6f44ab88a1dd59f51702d681ad0b57e6e2e374027dc5281f80e9f674d5746::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

