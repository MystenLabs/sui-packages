module 0xc2ee2f7dfb9ee168f0125d0233e1d97d202743b77e86b8fe393ed86b8777808::yupfun {
    struct YUPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4cp9JPLZBEAvw6KQbfxnQEEVHVd7wne1gD8FEZKupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YUPFUN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YUPFUN      ")))), trim_right(b"YUPFUN Token                    "), trim_right(b"YUPFUN: A cutting-edge DeFi platform that enables smooth token swaps across multiple blockchains at minimal fees. Featuring the YUPFUN token, Solana token, and USDC within the Solana ecosystem, YUPFUN ensures optimal trades via auto-routing and offers cross-chain bridging with Ethereum, Base, BSC, SUI, Tron, Avalanche,"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUPFUN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUPFUN>>(v4);
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

