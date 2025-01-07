module 0x521e0b123ecab46cbb81b0beead90b2583423eba342f9fe4487f09c2493ca06f::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BJ2ENyjuBGUQJr6CCDBcGAQNQDbayoNbDziDGrWSQQ4.png?size=lg&key=ae2169                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEIRO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEIRO   ")))), trim_right(b"Neiro                           "), trim_right(b"Neiro is our sweet 10-year-old rescue dog that has joined the Doge family, bringing joy and wagging tails. In memory of the legendary Kabosu, The Solana blockchain would like to give NEIRO a special gifta cozy Purple Hat that reflects her beautiful spirit and the love she brings to Sui                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v4);
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

