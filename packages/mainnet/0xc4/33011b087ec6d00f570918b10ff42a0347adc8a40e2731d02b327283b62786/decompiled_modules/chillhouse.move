module 0xc433011b087ec6d00f570918b10ff42a0347adc8a40e2731d02b327283b62786::chillhouse {
    struct CHILLHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9bec2cb2fe7d58eed75857298d42d3d5260039cd9d35aa747eff7dd9a3d9c8ff                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHILLHOUSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHILLHOUSE  ")))), trim_right(b"Just a chill house              "), trim_right(b"The real chill house drawn by Phillip Banks himself, the creator of chill guy                                                                                                                                                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLHOUSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLHOUSE>>(v4);
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

