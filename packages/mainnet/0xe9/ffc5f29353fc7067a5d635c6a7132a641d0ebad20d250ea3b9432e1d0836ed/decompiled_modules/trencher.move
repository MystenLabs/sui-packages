module 0xe9ffc5f29353fc7067a5d635c6a7132a641d0ebad20d250ea3b9432e1d0836ed::trencher {
    struct TRENCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f8f31f780d6ab3956ed2694367655c082a64e28ac5bc84204f48db9aec159c18                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRENCHER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRENCHER    ")))), trim_right(b"trencher                        "), trim_right(b"Artist @grizzle_art created the Trencher character as a hand drawn mascot for the Pumpfun trenches. The drawing went viral, inspiring an unaffiliated token called trencher. Instead of opposing it, Grizzle embraced the community and continues creating art with the character.                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCHER>>(v4);
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

