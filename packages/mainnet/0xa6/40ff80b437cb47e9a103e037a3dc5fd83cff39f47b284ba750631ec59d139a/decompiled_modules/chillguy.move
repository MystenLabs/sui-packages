module 0xa640ff80b437cb47e9a103e037a3dc5fd83cff39f47b284ba750631ec59d139a::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"730850a592f824453a58dfbeb6ece91d71bcc089ad37d9d6f2c8864317c43fc9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHILLGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHILLGUY    ")))), trim_right(b"Just a chill guy                "), trim_right(b"Just a Chill Guy. The first and only Chill Guy EVER deployed by the ACTUAL ARTIST HIMSELF, Phillip Banks. Royalties go to TeamWater, providing safer and cleaner water for the World.                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLGUY>>(v4);
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

