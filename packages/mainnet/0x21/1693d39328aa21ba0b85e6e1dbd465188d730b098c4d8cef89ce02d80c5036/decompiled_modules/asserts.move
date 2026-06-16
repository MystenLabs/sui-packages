module 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts {
    public fun must_amount(arg0: u64) {
        assert!(arg0 > 0, 107);
    }

    public fun must_amount_equals(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 109);
    }

    public fun must_amount_greater_than(arg0: u64, arg1: u64) {
        assert!(arg0 > arg1, 108);
    }

    // decompiled from Move bytecode v7
}

