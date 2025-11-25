module 0x89d1c746493d4f74ac19b53e9eb34f8d38b221e77099e9dce40d8563f50eaede::ut {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 999
        };
        0
    }

    // decompiled from Move bytecode v6
}

