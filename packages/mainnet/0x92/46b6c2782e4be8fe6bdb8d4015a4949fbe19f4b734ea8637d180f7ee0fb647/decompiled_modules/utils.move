module 0x9246b6c2782e4be8fe6bdb8d4015a4949fbe19f4b734ea8637d180f7ee0fb647::utils {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64, arg2: bool) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg0) > arg1) {
            201
        } else {
            0
        };
        if (v0 != 0 && !arg2) {
            abort v0
        };
        v0
    }

    // decompiled from Move bytecode v6
}

