module 0xd3977293c984ff2f916870aa53aed338d4b2aab2952e98be70c62bc3a886173a::format {
    public fun format(arg0: 0x1::string::String, arg1: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = vector[];
        let v1 = 0x1::string::length(&arg0);
        let v2 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v3 = 0x1::string::as_bytes(&arg0);
        if (v2 == 0) {
            return arg0
        };
        let v4 = 0;
        while (v4 < v1 - 1) {
            if (*0x1::vector::borrow<u8>(v3, v4) == 123 && *0x1::vector::borrow<u8>(v3, v4 + 1) == 125) {
                0x1::vector::push_back<u64>(&mut v0, v4);
            };
            v4 = v4 + 1;
        };
        assert!(v2 == 0x1::vector::length<u64>(&v0), 0);
        let v5 = 0x1::string::utf8(b"");
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v0)) {
            0x1::string::append(&mut v5, 0x1::string::substring(&arg0, v6, *0x1::vector::borrow<u64>(&v0, v7)));
            0x1::string::append(&mut v5, *0x1::vector::borrow<0x1::string::String>(&arg1, v7));
            v6 = *0x1::vector::borrow<u64>(&v0, v7) + 2;
            v7 = v7 + 1;
        };
        0x1::string::append(&mut v5, 0x1::string::substring(&arg0, v6, v1));
        v5
    }

    // decompiled from Move bytecode v7
}

