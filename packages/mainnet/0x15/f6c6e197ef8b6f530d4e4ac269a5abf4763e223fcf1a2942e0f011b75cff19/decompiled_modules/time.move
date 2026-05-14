module 0x15f6c6e197ef8b6f530d4e4ac269a5abf4763e223fcf1a2942e0f011b75cff19::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v7
}

