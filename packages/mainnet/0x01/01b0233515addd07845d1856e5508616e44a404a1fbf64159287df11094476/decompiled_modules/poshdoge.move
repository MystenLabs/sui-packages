module 0x101b0233515addd07845d1856e5508616e44a404a1fbf64159287df11094476::poshdoge {
    struct POSHDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSHDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"RrFe4x_Df_sVxw-H                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POSHDOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POSHDOGE    ")))), trim_right(b"Distinguished Doge              "), trim_right(b"In a world of crazy memes and unhinged internet culture, one doge rose above the restrefined, suave, and endlessly distinguished. Distinguished Doge, the epitome of canine sophistication, dons his iconic top hat and cuban cigar as a nod to a time when class reigned supreme. A true gentleman, he combines charm, wit, and"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSHDOGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSHDOGE>>(v4);
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

