module 0x126e4d65261fb8dedc2dfd7c4606502479f427d0ba64bc07878717511b948e4a::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/67nivxrx8QxkQ7H4phu7db3eawtoyjs6djuGETQKRhXL.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SATO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SATO        ")))), trim_right(b"SATO THE SNAKE                  "), trim_right(x"5361746f2074686520536e616b657c20206e657720636861726163746572200a0a4d6174742046757269652c2074686520766973696f6e61727920626568696e64207468652069636f6e69632050657065207468652046726f672c20697320636f6f6b696e672061206e657720626f6f6b2e20412077686f6c652063617374206f6620667265736820636861726163746572732068617320656d65726765642c20627574206f6e65207468617473207265616c6c79207475726e696e67206865616473206973205361746f2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATO>>(v4);
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

