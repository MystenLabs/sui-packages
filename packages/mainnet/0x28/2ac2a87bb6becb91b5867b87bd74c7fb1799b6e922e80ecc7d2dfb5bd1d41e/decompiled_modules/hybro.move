module 0x282ac2a87bb6becb91b5867b87bd74c7fb1799b6e922e80ecc7d2dfb5bd1d41e::hybro {
    struct HYBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"CNb5WxEdqkkG_x-K                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HYBRO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HYBRO       ")))), trim_right(b"HYBRO                           "), trim_right(b"In a freak accident of cosmic proportions, a multiverse portal ripped through the fabric of reality, fusing four of the most notorious beings from parallel dimensions into a single entity. The result? HYBROan unholy yet strangely charismatic fusion of Pepe, Brett, Andy, and Landwolf.                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYBRO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYBRO>>(v4);
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

