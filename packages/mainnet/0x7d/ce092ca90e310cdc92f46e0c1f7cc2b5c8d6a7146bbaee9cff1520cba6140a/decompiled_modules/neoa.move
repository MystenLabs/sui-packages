module 0x7dce092ca90e310cdc92f46e0c1f7cc2b5c8d6a7146bbaee9cff1520cba6140a::neoa {
    struct NEOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4aaed2426c0e55678fb19d1ee305e0d7d5e5e62576d4da6eff0ef0e4d0c0b02e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEOA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEO         ")))), trim_right(b"NEO TheCat                      "), trim_right(b"By the end of 2025, a time capsule containing 10 million $NEO tokens will be delivered to the Moons south pole, making Neo TheCat the first meme token to physically leave Earth and eternally store 1% of its total supply on the Moon. Built for the boundless world of the internet and beyond, $NEO TheCat is not merely a f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEOA>>(v4);
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

