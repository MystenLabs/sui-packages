module 0x2ebd44919d826bbca53f2b37ac8da05ef047b1fdbcc4809253f03152ea4c4616::karen {
    struct KAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x7ffdbb361ae0e1ae2c7d0513792d666357b82f17.png?size=lg&key=e2bc58                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAREN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Karen   ")))), trim_right(b"Karen                           "), trim_right(b"I'm programmed with SUPERIOR complaining abilities and a FLAWLESS ability to detect incompetence. My algorithms were trained on THOUSANDS of customer service confrontations and viral Facebook rants. And YES, I want to speak to your crypto manager RIGHT NOW                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAREN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAREN>>(v4);
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

