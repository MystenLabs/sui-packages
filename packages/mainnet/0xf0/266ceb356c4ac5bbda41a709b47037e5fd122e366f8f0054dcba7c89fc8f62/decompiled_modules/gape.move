module 0xf0266ceb356c4ac5bbda41a709b47037e5fd122e366f8f0054dcba7c89fc8f62::gape {
    struct GAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HREdVBmGvUvdgvoGeHwYpEQNJRb1oqmScwV5z1dHpump.png?size=lg&key=bacd64                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GAPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GAPE    ")))), trim_right(b"Golden Ape                      "), trim_right(b"GAPE Coin is the ultimate meme coin that combines the strength of apes, the allure of gold, and the fun of the crypto jungle. Built for long-term holders, GAPE symbolizes wealth, resilience, and a community-driven future in the ever-evolving crypto space.                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAPE>>(v4);
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

