module 0x6d264cc3d4b7b81a7e3e47403b335d1d933ceb03dacc4328214f10bf8937a239::verify {
    public fun verify_recipient(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg1), 0);
    }

    // decompiled from Move bytecode v6
}

