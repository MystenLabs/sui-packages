module 0x3c15277a054336c29f55c4dc5e7a9fa4c8d9046d0ec573193d7b1ed89cb045d5::gentlemen {
    struct GENTLEMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENTLEMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AyzkYPLwct8ScLu7d8DyQgCg1E3fzZdaY7Uh9Mfybonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GENTLEMEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GENTLEMEN   ")))), trim_right(b"The League of Gentlemen         "), trim_right(b"Born from an anon on 4chan in 2008. Before GigaChad. Before Sigma. There was already a GENTLEMEN.                                                                                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENTLEMEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENTLEMEN>>(v4);
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

