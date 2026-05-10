module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts {
    public fun must_amount(arg0: u64) {
        assert!(arg0 > 0, 107);
    }

    public fun must_amount_equals(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 109);
    }

    public fun must_amount_greated_than(arg0: u64, arg1: u64) {
        assert!(arg0 > arg1, 108);
    }

    public(friend) fun must_profit_at_least(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 110);
    }

    // decompiled from Move bytecode v7
}

