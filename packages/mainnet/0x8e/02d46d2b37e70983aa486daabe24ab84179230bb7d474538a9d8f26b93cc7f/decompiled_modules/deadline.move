module 0x8e02d46d2b37e70983aa486daabe24ab84179230bb7d474538a9d8f26b93cc7f::deadline {
    public fun check(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

