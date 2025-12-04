module 0x460887a66b9976a746ad522ad42ed73ed1929bd5d028871d3579aaf419b3fe2f::celestora {
    struct CELESTORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELESTORA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"de2e63c544b6989dd07d768087fbd062f952e7b4e9bfae14563c7b83a87ecc46                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CELESTORA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CELESTORA   ")))), trim_right(b"CELESTORA                       "), trim_right(b"CELESTORA gives creators a flexible foundation to build digital worlds, meme ecosystems, and NFT-driven experiences. Fast, modular, and community-powered.                                                                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELESTORA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CELESTORA>>(v4);
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

