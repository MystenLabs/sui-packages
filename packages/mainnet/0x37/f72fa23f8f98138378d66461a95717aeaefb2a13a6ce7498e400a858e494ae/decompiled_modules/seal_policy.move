module 0x37f72fa23f8f98138378d66461a95717aeaefb2a13a6ce7498e400a858e494ae::seal_policy {
    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_prefix(0x2::address::to_bytes(0x2::tx_context::sender(arg1)), arg0), 1);
    }

    // decompiled from Move bytecode v6
}

