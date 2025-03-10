module 0x374144dbed54caabb4aab39ad91b550bba6ce79e1e8f74a6b93b28579ccd98c5::rec {
    struct REC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F7RBxuCeRtsTrhGsEdjWHUC5dZUVHmDj9wL8iYpW1xWp.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REC         ")))), trim_right(b"Real Estate Coin                "), trim_right(b"REC is a crypto meme experiment designed to identify public interest in the implementation of its underlying idea. REC is the beginning of the future crypto space in the real estate sector, enabling the use of crypto assets for buying, selling, and exchanging shares of real estate.                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REC>>(v4);
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

