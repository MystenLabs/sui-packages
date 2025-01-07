module 0x78e2514b7b97788b4c72ed6c6782fe9e2f0c2b825c11bdd57ca06fe815215b8a::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/polygon/0x433cde5a82b5e0658da3543b47a375dffd126eb6.png?size=lg&key=164096                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOON    ")))), trim_right(b"GOON                            "), trim_right(b"The GOON token is the representation of the SUI ecosystem's past and future. GOON becomes the symbol of SUI's dedicated community, vibrant energy, and robust ecosystem, heralding a new era as the premier destination for founders, builders, artists, and meme creators alike.                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOON>>(v4);
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

