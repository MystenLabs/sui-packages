module 0xb79fb42144dad86f2154bc1cf4ca47d5e07a7372abef3feb1efd5943ae22c134::solmas {
    struct SOLMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"790d2ec68f7746de62e866af6a04a6cc133d95546fb632d78d8aa1fa18d0cc66                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLMAS      ")))), trim_right(b"Solmas                          "), trim_right(b"SOLMAS is here to light up the holidays on Solana! Built for the season of giving (and gains), SOLMAS brings festive fun, community rewards, and that classic meme magic to the blockchain. Whether you're here to spread cheer or stack your bags, this Christmas is all about SOLMAS  where every holders list ends with. to t"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLMAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLMAS>>(v4);
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

