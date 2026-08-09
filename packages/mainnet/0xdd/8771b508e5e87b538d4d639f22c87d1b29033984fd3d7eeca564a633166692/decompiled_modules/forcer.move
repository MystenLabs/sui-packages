module 0xdd8771b508e5e87b538d4d639f22c87d1b29033984fd3d7eeca564a633166692::forcer {
    public fun require_even(arg0: u64) {
        assert!(arg0 % 2 == 0, 42);
    }

    public fun side(arg0: u64) : vector<u8> {
        if (arg0 % 2 == 0) {
            b"head"
        } else {
            b"tail"
        }
    }

    // decompiled from Move bytecode v7
}

