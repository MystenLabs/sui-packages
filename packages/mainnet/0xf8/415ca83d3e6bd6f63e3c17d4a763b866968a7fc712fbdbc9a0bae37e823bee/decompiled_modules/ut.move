module 0xf8415ca83d3e6bd6f63e3c17d4a763b866968a7fc712fbdbc9a0bae37e823bee::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

