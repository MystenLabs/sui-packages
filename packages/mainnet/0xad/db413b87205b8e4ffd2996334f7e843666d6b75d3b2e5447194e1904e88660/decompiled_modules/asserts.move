module 0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::asserts {
    public fun must_amount(arg0: u64) {
        assert!(arg0 > 0, 107);
    }

    public fun must_amount_equals(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 109);
    }

    public fun must_sender(arg0: &0x2::tx_context::TxContext, arg1: address) {
        assert!(0x2::tx_context::sender(arg0) == arg1, 111);
    }

    // decompiled from Move bytecode v7
}

