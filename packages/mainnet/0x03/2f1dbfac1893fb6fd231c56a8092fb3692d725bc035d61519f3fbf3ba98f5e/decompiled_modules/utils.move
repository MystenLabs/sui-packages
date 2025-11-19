module 0x32f1dbfac1893fb6fd231c56a8092fb3692d725bc035d61519f3fbf3ba98f5e::utils {
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

