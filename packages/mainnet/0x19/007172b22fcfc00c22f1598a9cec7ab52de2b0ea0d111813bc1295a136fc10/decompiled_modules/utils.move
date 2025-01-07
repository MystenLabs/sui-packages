module 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils {
    public fun ceil_div(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    public fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

