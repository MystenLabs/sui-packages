module 0xd3977293c984ff2f916870aa53aed338d4b2aab2952e98be70c62bc3a886173a::format {
    public fun format(arg0: 0x1::string::String, arg1: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = vector[];
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        let v2 = 0x1::string::as_bytes(&arg0);
        if (v1 == 0) {
            return arg0
        };
        let v3 = 0;
        while (v3 < 0x1::string::length(&arg0) - 1) {
            if (*0x1::vector::borrow<u8>(v2, v3) == 123 && *0x1::vector::borrow<u8>(v2, v3 + 1) == 125) {
                0x1::vector::push_back<u64>(&mut v0, v3);
            };
            v3 = v3 + 1;
        };
        assert!(v1 == 0x1::vector::length<u64>(&v0), 0);
        let v4 = 0x1::string::utf8(b"");
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v0)) {
            0x1::string::append(&mut v4, 0x1::string::substring(&arg0, v5, *0x1::vector::borrow<u64>(&v0, v6)));
            0x1::string::append(&mut v4, *0x1::vector::borrow<0x1::string::String>(&arg1, v6));
            v5 = *0x1::vector::borrow<u64>(&v0, v6) + 2;
            v6 = v6 + 1;
        };
        v4
    }

    // decompiled from Move bytecode v6
}

