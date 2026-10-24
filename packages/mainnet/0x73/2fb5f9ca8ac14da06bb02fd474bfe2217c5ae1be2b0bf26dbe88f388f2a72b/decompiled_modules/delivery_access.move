module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::delivery_access {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        let v0 = 0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert!(0x1::vector::length<u8>(&arg0) >= 0x1::vector::length<u8>(&v1), 0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 0);
            v2 = v2 + 1;
        };
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::can_decrypt(arg1, 0x2::tx_context::sender(arg3)), 0);
    }

    // decompiled from Move bytecode v7
}

