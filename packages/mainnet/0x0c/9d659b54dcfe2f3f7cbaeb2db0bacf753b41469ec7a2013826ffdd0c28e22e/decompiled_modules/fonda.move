module 0xc9d659b54dcfe2f3f7cbaeb2db0bacf753b41469ec7a2013826ffdd0c28e22e::fonda {
    struct FONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A3GCAAwFxAUgx97j9uw8Vkf8MaFqUut2tsyAXq9Cpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FONDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FOND        ")))), trim_right(b" Fondue Coin                    "), trim_right(x"466f6e64756520436f696e2020202024464f4e44200a426f726e20696e2074686520537769737320416c70732e204275696c74206f6e20536f6c616e612e0a24464f4e4420697320612063756c747572616c206d656c742020736c6f772c207265616c2c20696e74656e74696f6e616c2e0a4d757369632c2067616d696e672c207265737065637420616e6420766962652e204e6f20687970652e0a5765656b6c7920746f6b656e206275726e732066756c6c79207472616e73706172656e742e0a50726f746563746564206279207468652042656c6c20466f7263653a2057696c68656c6d2c2042656c6c6120262057616c7465722e0a0a50726f6f662074686174206576656e2061206c61756e6368206f6e2050756d702046756e2063616e206c65616420746f207265616c2c206c617374696e672076616c75652e0a41"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONDA>>(v4);
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

