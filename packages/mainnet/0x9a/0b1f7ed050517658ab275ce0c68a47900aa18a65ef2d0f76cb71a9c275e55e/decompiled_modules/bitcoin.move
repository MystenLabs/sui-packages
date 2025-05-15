module 0x9a0b1f7ed050517658ab275ce0c68a47900aa18a65ef2d0f76cb71a9c275e55e::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/55hPoctduMUBb4acaCVGDZwQZ9oeJAFMx5xwtqTupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BITCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BITCOIN     ")))), trim_right(b"Bitcoin on Believe              "), trim_right(b"Built on blockchain technology for maximum security and peace of mind for all transactions.                                                                                                                                                                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v4);
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

