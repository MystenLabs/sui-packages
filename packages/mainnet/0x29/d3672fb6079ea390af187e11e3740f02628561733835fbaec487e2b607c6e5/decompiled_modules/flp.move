module 0x29d3672fb6079ea390af187e11e3740f02628561733835fbaec487e2b607c6e5::flp {
    struct FLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/37psxLf5hC3dQNHbKok88K9S1wUgV4JvsVu21PeNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLP         ")))), trim_right(b"Flipr                           "), trim_right(b"Flipr is a real world asset-based tokenized AI Agent that pulls real estate listings and demographical information to ascertain the best quick flips on the market.  Flipr's platform will allow anyone to own fractionalized real estate, and provides real-time data to help you find the most lucrative real estate around.  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLP>>(v4);
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

