module 0xfabfc63a1d67c37d9c0250bc3efeb96a3c56fb20b9a6d92e3b89dd151f54af5c::vault {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0 == 0x2::bcs::to_bytes<address>(&v0), 1);
    }

    // decompiled from Move bytecode v6
}

