module 0x5712839999c0073c483ad540a041de1b2bd8c4690e6f4e956aaa76074009a449::efa {
    struct EFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HQJ3sGXitBvJaWkT7rsWLw711VuKhfeYSMoQi4uXpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EFA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EFA         ")))), trim_right(b"ELON FOR AMERICA                "), trim_right(b"Bold ideas need bold leadership. Lets shape a future where innovation meets responsibilityand results follow.                                                                                                                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EFA>>(v4);
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

