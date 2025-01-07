module 0xcee73fc2a5c3ea9c59e965396b59bfd7de84321b2115b9ed9ed337772804fa77::lolli {
    struct LOLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BJ2ENyjuBGUQJr6CCDBcGAQNQDbayoNbDziDGrWSQQ4.png?size=lg&key=ae2169                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOLLI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOLLI   ")))), trim_right(b"Lollipup                        "), trim_right(b"LOLLI is our sweet 5-year-old rescue dog that has joined the Doge family, bringing joy and wagging tails. In memory of the legendary Kabosu, The SUI blockchain would like to give LOLLI a special gifta cozy Purple Hat that reflects her beautiful spirit and the love she brings to Sui                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLLI>>(v4);
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

