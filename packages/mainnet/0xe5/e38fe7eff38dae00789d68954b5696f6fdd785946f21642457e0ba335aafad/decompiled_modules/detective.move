module 0xe5e38fe7eff38dae00789d68954b5696f6fdd785946f21642457e0ba335aafad::detective {
    struct DETECTIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DETECTIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ee08494b3be1e7940c2481ceea64732ebcf1004b189a538dface9f21bb09294f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DETECTIVE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DETECTIVE   ")))), trim_right(b"Just can't prove it             "), trim_right(b"James Doakes, the funniest character to ever air on TV. The strong expressions used to express his distrust and suspicion have made it the basis for a perfect meme. With the first episode of Dexter launched in 2006, it's been one of the internet's favorite memes for two decades now. The first detective meme to go viral"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DETECTIVE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DETECTIVE>>(v4);
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

