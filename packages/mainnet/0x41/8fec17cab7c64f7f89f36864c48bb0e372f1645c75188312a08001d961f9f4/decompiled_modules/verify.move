module 0x418fec17cab7c64f7f89f36864c48bb0e372f1645c75188312a08001d961f9f4::verify {
    public fun verify_recipient(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg1), 0);
    }

    // decompiled from Move bytecode v6
}

