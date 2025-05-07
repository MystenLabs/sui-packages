module 0x2753893a5c7cab6c6509f3cfc93fdb99fddd477d70562d3c9517bbb62cb46212::merkle_proof {
    public fun lt(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 == 0x1::vector::length<u8>(&arg1), 0);
        while (v0 < v1) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) < *0x1::vector::borrow<u8>(&arg1, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(&arg0, v0) > *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

