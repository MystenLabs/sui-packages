module 0x97319400260dcccb700ba45ffacf177bc6bb53587714f06a7f2398c3aae8434e::thefeds {
    struct THEFEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"aba5fd12faef676074e42c13e9db6d95cebad0542099bf27a604bcf77d204589                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THEFEDS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"THEFEDS     ")))), trim_right(b"UNFEDERAL RESERVE               "), trim_right(x"54686520756e6665646572616c20726573657276652077617320637265617465642062656361757365206f66204a65726f6d65277320696e6162696c69747920746f20636f6d62617420696e666c6174696f6e2e204f757220736f6c7574696f6e3f20426974636f696e20616e64206f6e2d636861696e20676f6c642e0a0a486f6c6420245448454645445320616e64207265636569766520626f74682e204f757220746f6b656e2d6c6576656c20746178206973207573656420746f2066756e642074686973206f7065726174696f6e20736f2065766572796f6e652063616e206561742c206e6f74206a7573742054484520464544532e0a0a546865792077616e7420796f7520746f206f776e206e6f7468696e6720616e642062652068617070792e2057652077616e7420796f7572207068616e746f6d2066756c6c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFEDS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEFEDS>>(v4);
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

