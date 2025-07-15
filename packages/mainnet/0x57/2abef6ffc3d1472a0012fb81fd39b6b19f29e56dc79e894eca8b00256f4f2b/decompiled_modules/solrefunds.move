module 0x572abef6ffc3d1472a0012fb81fd39b6b19f29e56dc79e894eca8b00256f4f2b::solrefunds {
    struct SOLREFUNDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLREFUNDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4UmzC4HMbH2B2Pc95cYWkAUdALqjB687ThJLX9bMpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLREFUNDS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Solrefunds  ")))), trim_right(b"Sol Refunds                     "), trim_right(b"The Solana Blockchain charges rent for unused SPL token accounts, even after you've sold your tokens and they have 0 balances. Our Platform helps you identify and Close those unused token accounts, letting you safely refund your rent. It's simple all you have to do is connect your wallet, press close and you get the re"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLREFUNDS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLREFUNDS>>(v4);
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

