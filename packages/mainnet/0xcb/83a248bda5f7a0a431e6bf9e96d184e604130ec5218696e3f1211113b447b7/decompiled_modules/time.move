module 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v6
}

