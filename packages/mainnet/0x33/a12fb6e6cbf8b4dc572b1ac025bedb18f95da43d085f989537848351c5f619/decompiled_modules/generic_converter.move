module 0x33a12fb6e6cbf8b4dc572b1ac025bedb18f95da43d085f989537848351c5f619::generic_converter {
    public fun u128_to_eth_string(arg0: u128) : 0x1::string::String {
        let v0 = arg0 % 1000000000;
        if (v0 == 0) {
            return u128_to_string(arg0 / 1000000000)
        };
        let v1 = u128_to_string(v0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v1));
        while (0x1::vector::length<u8>(&v2) < 9) {
            0x1::vector::push_back<u8>(&mut v2, 48);
        };
        while (0x1::vector::length<u8>(&v2) > 1 && *0x1::vector::borrow<u8>(&v2, 0x1::vector::length<u8>(&v2) - 1) == 48) {
            0x1::vector::pop_back<u8>(&mut v2);
        };
        let v3 = u128_to_string(arg0 / 1000000000);
        0x1::string::append(&mut v3, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v3, 0x1::string::utf8(v2));
        v3
    }

    public fun u128_to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun u128_to_vec8(arg0: u128) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

