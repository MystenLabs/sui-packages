module 0xb2568e9dda1726c3d4def41f1558310beb52950c8af01d98a746fbfed81d9b30::virusa {
    struct VIRUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/28h1NHtVWNS5xbSKZXAsmHr6d8CrqW69BfDm7VQDXSxN.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIRUSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIRUS       ")))), trim_right(b"VIRUS                           "), trim_right(x"5468652056697275732069732061207265766f6c7574696f6e617279206e6577207265776172647320746f6b656e2074686174206861732061206f6e65206f66206b696e642061697264726f702073797374656d2064657369676e656420746f206b6565702074686520766972757320737072656164696e672e204561726e2077425443202b2073746f636b73206c696b65204170706c652c205465736c612c204e56494449412026206d6f72652e200a0a596f752068617665206265656e20746f6c6420746f20656174207a6520627567732c2068617665206e6f7468696e672c20616e6420796f752077696c6c2062652068617070792e205669727573206973206120776179206f66206669676874696e67206261636b20616761696e73742074686520656c69746573202620676f7665726e6d656e74732077686f2077"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRUSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRUSA>>(v4);
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

