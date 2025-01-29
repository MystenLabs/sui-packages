module 0xf9e971c9b6d1c6bb1ae17d7cb498f087ac5eeefe26c2d734bc65a004afd9481a::catturd {
    struct CATTURD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTURD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4wQ77vLgdeFs6PTM3TEcFjV7oAV5ucWX8e9Hm6r75UFA.png?claimId=wFZHFL-vRU4Dtrq6                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATTURD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CATTURD     ")))), trim_right(b"CAT TURD                        "), trim_right(b"The turd you can't flush. The homage to the fury political meme lord that ruffles the snowflakes both left right and center. The financial system is broken, so why not meme about it?                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTURD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATTURD>>(v4);
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

