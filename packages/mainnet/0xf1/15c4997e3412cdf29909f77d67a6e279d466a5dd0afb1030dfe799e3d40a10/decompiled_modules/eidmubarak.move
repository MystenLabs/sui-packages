module 0xf115c4997e3412cdf29909f77d67a6e279d466a5dd0afb1030dfe799e3d40a10::eidmubarak {
    struct EIDMUBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIDMUBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7Nrxw1sRiEAtkt7pqgnTtkYeK9Dx6HJbXJoacLApump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EIDMUBARAK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EidMubarak  ")))), trim_right(b"Eid Mubarak                     "), trim_right(b"The world's first memecoin celebrating the global festival of Eid with blockchain-powered giving, community, and festive vibes! Celebrated by 2+ Billion Muslims worldwide in over 150 countries, bringing the spirit of Eid to Web3.                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIDMUBARAK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIDMUBARAK>>(v4);
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

