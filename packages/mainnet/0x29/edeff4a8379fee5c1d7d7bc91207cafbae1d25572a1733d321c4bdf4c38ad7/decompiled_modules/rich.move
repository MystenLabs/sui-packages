module 0x29edeff4a8379fee5c1d7d7bc91207cafbae1d25572a1733d321c4bdf4c38ad7::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ai-agent.sgp1.cdn.digitaloceanspaces.com/images/cd4dd9f2433fd31a2cc2f62713306a85_1740079100467_omnifi.png                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RICH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RICH    ")))), trim_right(b"omnifi                          "), trim_right(x"576520636f6e6e6563742074686520646f7473206163726f737320636861696e732c206272696e67696e6720796f753a0a0a2d2041492d506f776572656420496e7369676874733a20536d6172746572206465636973696f6e732c207461696c6f72656420746f20796f752e0a2d20416c6c2d696e2d4f6e65204163636573733a2045766572792066696e616e6369616c20746f6f6c2c20696e206f6e6520706c6163652e0a2d20596f7572205765616c74682c2053696d706c69666965643a2046726f6d2061737365747320746f206f70706f7274756e69746965732c206566666f72746c6573736c79206d616e616765642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICH>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

