module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::private {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg1));
        assert!(0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::bytes_start_with(&arg0, &v0), 2);
    }

    // decompiled from Move bytecode v7
}

