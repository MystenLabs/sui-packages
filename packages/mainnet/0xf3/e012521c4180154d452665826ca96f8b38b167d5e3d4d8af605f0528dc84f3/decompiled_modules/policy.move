module 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::Machine, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::id_bytes(arg1), 0);
        assert!(0xf3e012521c4180154d452665826ca96f8b38b167d5e3d4d8af605f0528dc84f3::machine::owner(arg1) == 0x2::tx_context::sender(arg2), 1);
    }

    // decompiled from Move bytecode v7
}

