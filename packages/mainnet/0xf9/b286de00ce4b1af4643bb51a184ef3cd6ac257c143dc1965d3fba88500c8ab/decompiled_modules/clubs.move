module 0xf9b286de00ce4b1af4643bb51a184ef3cd6ac257c143dc1965d3fba88500c8ab::clubs {
    struct CLUBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUBS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1df14defe0a89acf6014f51d865c28a6b574437a014ce6c4290da883f76c2131                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLUBS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CLUBS       ")))), trim_right(b"Book of Clubs                   "), trim_right(b"Book of Clubs ($CLUBS) is a conspiracy-themed meme coin woven into the Storybook LLC ecosystem of novels, films, and digital media through Clubs Production. More than a token, its a gateway to contests, publications, and community-driven storytelling that blends crypto with culture.                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUBS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUBS>>(v4);
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

