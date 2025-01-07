module 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils {
    public fun concat(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v0, v3));
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v1)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v1, v4));
            v4 = v4 + 1;
        };
        0x1::string::utf8(v2)
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0;
        while (v2 < v1 / 2) {
            let v3 = v1 - v2 - 1;
            *0x1::vector::borrow_mut<u8>(&mut v0, v2) = *0x1::vector::borrow<u8>(&v0, v3);
            *0x1::vector::borrow_mut<u8>(&mut v0, v3) = *0x1::vector::borrow<u8>(&v0, v2);
            v2 = v2 + 1;
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

