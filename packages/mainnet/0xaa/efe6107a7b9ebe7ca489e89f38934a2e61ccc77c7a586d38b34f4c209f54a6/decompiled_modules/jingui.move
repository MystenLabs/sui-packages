module 0xaaefe6107a7b9ebe7ca489e89f38934a2e61ccc77c7a586d38b34f4c209f54a6::jingui {
    struct JINGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x826dcbdac81a892428aa2bc5ecdd8cb6cd402f01.png?size=lg&key=c252d4                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JINGUI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JINGUI  ")))), trim_right(b"Jin Gui                         "), trim_right(b"The Chinese Spring Festival Gala, the biggest event in the Chinese TV calendar and watched by more than 20 billion people worldwide, has just concluded and the newest mascot for the new year has been revealed - the goldern turtle, JIN GUI!                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINGUI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINGUI>>(v4);
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

