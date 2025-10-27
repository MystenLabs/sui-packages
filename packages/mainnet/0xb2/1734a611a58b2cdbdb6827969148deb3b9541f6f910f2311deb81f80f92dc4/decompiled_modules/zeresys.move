module 0xb21734a611a58b2cdbdb6827969148deb3b9541f6f910f2311deb81f80f92dc4::zeresys {
    struct ZERESYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERESYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3c51e22513a89d64e8f859666e951ce4239ceb922f569b6f52f57638329fdc5b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZERESYS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZERESYS     ")))), trim_right(b"Zeresys Protocol                "), trim_right(b"ZERESYS PROTOCOL is the sister system - an autonomous on-chain implementation inspired by Zerebro's vision. We've built a self-sustaining deflationary mechanism that combines AI-inspired decision making with transparent blockchain operations - creating a truly autonomous protocol that rewards holders and burns supply a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERESYS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZERESYS>>(v4);
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

