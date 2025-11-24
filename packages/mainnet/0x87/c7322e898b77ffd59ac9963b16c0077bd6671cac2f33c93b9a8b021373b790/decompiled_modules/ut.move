module 0x87c7322e898b77ffd59ac9963b16c0077bd6671cac2f33c93b9a8b021373b790::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

