module 0x6f6ce019d08dc3479de81d617ce28f38a3bec82e9ea791b84de121f763f2bf0b::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

