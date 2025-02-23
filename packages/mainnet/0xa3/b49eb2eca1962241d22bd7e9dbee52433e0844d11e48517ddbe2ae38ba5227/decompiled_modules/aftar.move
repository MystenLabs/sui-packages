module 0xa3b49eb2eca1962241d22bd7e9dbee52433e0844d11e48517ddbe2ae38ba5227::aftar {
    struct AFTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"uZmbEYLfI7fHhpop                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AFTAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AFTAR       ")))), trim_right(b"AFTAR                           "), trim_right(b"Meme coins are no longer just about being silly and fun, the community is evolving and looking to make a difference.  AFTAR (Advocating For The Amazon Rainforest) was created with a purpose.  Come join this journey and be a part of a community the is re-writing the crypto landscape.                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFTAR>>(v4);
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

