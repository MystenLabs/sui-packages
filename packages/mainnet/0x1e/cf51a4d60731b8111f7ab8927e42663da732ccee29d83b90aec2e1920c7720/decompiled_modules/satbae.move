module 0x1ecf51a4d60731b8111f7ab8927e42663da732ccee29d83b90aec2e1920c7720::satbae {
    struct SATBAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATBAE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/34s1uzZQXxB66NyAbzbT1AT14gszLJAWikpF2wSGpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SATBAE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SATBAE      ")))), trim_right(b"SATOSHI BAE                     "), trim_right(b"Degen Pumpster Launch #1 Satoshi Bae is a crypto meme coin inspired by the legendary figure behind Bitcoin, Satoshi Nakamoto. Embodying the light-hearted essence of the meme coin space, Satoshi Bae blends humor with the iconic origin story of cryptocurrency. The project leverages a playful caricature of Satoshi making "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATBAE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATBAE>>(v4);
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

