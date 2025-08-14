module 0xf2a6a1eea1b7b0ed302333c4d28b915ddeb94713b8c7024b9609ebca2c80ce22::fsr {
    struct FSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3naMj3jj6877gfXy6VC4fhaUPkwZ5Y7y8UWi5QeXbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FSR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FSR         ")))), trim_right(b"Fusior AI                       "), trim_right(b"Fusior is a cutting-edge AI platform revolutionizing crypto trading with multiple AI technologies for superior signals on Solana. Far beyond a simple chatbot, it offers real utility and innovative features to provide actionable insights by analyzing market data, social media sentiment, and news in real-time, helping us"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSR>>(v4);
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

