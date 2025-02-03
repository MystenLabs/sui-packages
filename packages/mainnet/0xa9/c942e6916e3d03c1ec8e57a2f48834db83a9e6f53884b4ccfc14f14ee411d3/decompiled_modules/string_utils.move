module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::string_utils {
    public fun to_ascii(arg0: &0x1::string::String) : 0x1::ascii::String {
        let v0 = *0x1::string::bytes(arg0);
        while (!0x1::vector::is_empty<u8>(&v0) && *0x1::vector::borrow<u8>(&v0, 0x1::vector::length<u8>(&v0) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut v0);
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            if (0x1::ascii::is_valid_char(v3)) {
                0x1::vector::push_back<u8>(&mut v1, v3);
                v2 = v2 + 1;
                continue
            };
            if (v3 >= 192) {
                0x1::vector::push_back<u8>(&mut v1, 63);
                if (v3 >= 240) {
                    v2 = v2 + 4;
                    continue
                };
                if (v3 >= 224) {
                    v2 = v2 + 3;
                    continue
                };
                v2 = v2 + 2;
            };
        };
        0x1::ascii::string(v1)
    }

    // decompiled from Move bytecode v6
}

