module 0x6ff18a1dc976ae86c3dff49c1e466a1ca73625603e2a387a43a0c13b8162b23d::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmeLVzPe1wv4eqR3ypVATGf5BjdQpFan3sNWF7GazFneL9                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOSU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOSU    ")))), trim_right(b"Book Of Sui                     "), trim_right(b"Memecoin on the most Degen chain + This digital book is linked with metadata to the token and the Book has even more links to images stored SUI/ONCHAIN + A decentralized social network app + Tools to create memes + CC0 Meme Clipart Collection - all of these here in one memecoin!                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSU>>(v4);
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

