module 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

