module 0xe8e1cd06c9e26f6cec5b9750a6517a0019c3d25f24d3b853136b406c3b17fe9d::wing {
    struct WING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3UYS3XXYC9yWvNyBWFKqqb5w9YQfX65RQzoAKd8jEUCB.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WING        ")))), trim_right(b"Shiba $Wing                     "), trim_right(x"5468652070726f7564206f776e657273206f662074686520536869626120496e75204c6f676f202620666f756e64657273206f66207468652053686962612057696e67732072657374617572616e74206672616e63686973652e0a0a506172746e6572656420776974682057616c6c7374726565746265747320575342204077616c6c7374726565746265747320616e6420426164204461797320404d617276656c6f75734e6674735f0a0a42757420746861742773206e6f7420616c6c2c20746869732069732077686572652069742067657473207265616c6c792073706963792d2077697468206b696c6c657220706172746e65727368697073207769746820506179206974204e6f7720262042616420446179732c203525206f662070726f66697420676574732066656420696e746f2074686520746f6b656e206368"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WING>>(v4);
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

