module 0x2e810cd602d1d11037b195fd1d0ffe60c0375de9dbea4b1b0aefb18973d5fe02::policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0 == 0x2::bcs::to_bytes<address>(&v0), 77);
    }

    // decompiled from Move bytecode v7
}

