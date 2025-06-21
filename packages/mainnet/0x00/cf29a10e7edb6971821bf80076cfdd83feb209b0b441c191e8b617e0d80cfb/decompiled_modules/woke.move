module 0xcf29a10e7edb6971821bf80076cfdd83feb209b0b441c191e8b617e0d80cfb::woke {
    struct WOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/XKjnqXtZ4QuJvbk54FurZQDteqioWRUtB9uHDA5oVsf.png?claimId=LKyTFhjeNDgtElHt                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WOKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WOKE        ")))), trim_right(b"RIP WOKE                        "), trim_right(b"Elon Musk's statement, \"Baby, what happened to Woke? Dead, my darling, Woke is dead,\" likely means he believes \"woke\" culture, which he has criticized as excessive political correctness, has lost its influence. Originally about social justice awareness, \"woke\" is now a polarizing term. Some evidence, like 2024 reports,"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOKE>>(v4);
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

