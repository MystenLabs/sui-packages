module 0x7f35acc91ca706f9be844f99c63062c724d811b50bfb2bded1800a7ed19e2b6d::grapelu {
    struct GRAPELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPELU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7460d642927ffbe92474069646b7c099cf38eac4af60883a0c08a7307806bf1a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRAPELU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRAPELU     ")))), trim_right(b"Grapelu                         "), trim_right(b"GRAPELU was inspired by a gentle-hearted cat who always knew how to make people smile. With round curious eyes and little antics that melt hearts, GRAPELU brings warmth to every corner it touches. The name embodies simple joya small world filled with soft laughter, lighthearted moments, and memories worth keeping.     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPELU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAPELU>>(v4);
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

