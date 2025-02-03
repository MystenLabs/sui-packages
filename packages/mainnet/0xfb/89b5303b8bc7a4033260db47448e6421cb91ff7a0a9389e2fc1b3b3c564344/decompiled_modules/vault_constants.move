module 0xfb89b5303b8bc7a4033260db47448e6421cb91ff7a0a9389e2fc1b3b3c564344::vault_constants {
    fun get_lock_duration(arg0: u64) : u64 {
        if (arg0 >= 1 && arg0 <= 8) {
            1
        } else if (arg0 >= 9 && arg0 <= 16) {
            2
        } else if (arg0 >= 17 && arg0 <= 24) {
            3
        } else if (arg0 >= 25 && arg0 <= 32) {
            4
        } else if (arg0 >= 33 && arg0 <= 40) {
            5
        } else if (arg0 >= 41 && arg0 <= 48) {
            6
        } else if (arg0 >= 49 && arg0 <= 56) {
            7
        } else if (arg0 >= 57 && arg0 <= 64) {
            8
        } else {
            1
        }
    }

    public fun get_lock_duration_for_level(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        0x2::clock::timestamp_ms(arg0) + get_lock_duration(arg1) * 2629746000
    }

    // decompiled from Move bytecode v6
}

