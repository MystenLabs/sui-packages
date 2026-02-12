module 0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::utils {
    public fun join_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

