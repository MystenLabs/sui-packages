module 0x6e0ad1ebda52dabacd24c39eb79d8ccc6c10fd71f58620f66e23b5d6ee4feb84::verify {
    public(friend) fun verify_recipient(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg1), 0);
    }

    // decompiled from Move bytecode v6
}

