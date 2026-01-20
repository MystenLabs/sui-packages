module 0x790d89fae525d757e0be2d4f154db7c53e97c2aa939b9f6a1201c573de117326::access {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg1));
        assert!(0x1::vector::length<u8>(&arg0) >= 32, 1);
        let v1 = true;
        let v2 = 0;
        while (v2 < 32) {
            if (*0x1::vector::borrow<u8>(&arg0, v2) != *0x1::vector::borrow<u8>(&v0, v2)) {
                v1 = false;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 0);
    }

    // decompiled from Move bytecode v6
}

