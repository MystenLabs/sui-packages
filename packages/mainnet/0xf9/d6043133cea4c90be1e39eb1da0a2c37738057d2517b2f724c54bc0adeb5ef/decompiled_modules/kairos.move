module 0xf9d6043133cea4c90be1e39eb1da0a2c37738057d2517b2f724c54bc0adeb5ef::kairos {
    struct KAIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e098fc358f6dbd458f7219bbcfe40a6a1cfde81967446d6e257b8465564d589c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAIROS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KAIROS      ")))), trim_right(b"Kairos Sniper Bot               "), trim_right(b"Kairos is a lightning-fast telegram bot that snipes new tokens on Solana. By holding $KAIROS, you get an edge in the market, earning passive income from automatic Solana airdrops, and benefit from a deflationary supply with regular token burns.                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAIROS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAIROS>>(v4);
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

