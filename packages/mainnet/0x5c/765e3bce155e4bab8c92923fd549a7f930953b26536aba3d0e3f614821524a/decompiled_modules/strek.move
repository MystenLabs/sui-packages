module 0x5c765e3bce155e4bab8c92923fd549a7f930953b26536aba3d0e3f614821524a::strek {
    struct STREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STREK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DazNNvVykuX7TdwfMcHU2qXq87Tycmv9kQP7EpufQH7L.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STREK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STREK       ")))), trim_right(b"Space Travel Coin               "), trim_right(b"STREK is a Utility  meme coin that will allow STREK owners to explore space travel. They will be able to visit distant galaxies by traveling in a space ship and also land on exotic planets and meet new life forms. STREK Coin  brings  space travel dreams to Web3!  There will be Play-to-earn games, airdrops & rewards all"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STREK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STREK>>(v4);
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

