module 0xb7ec8304e7468ebcf2e82aefa69875550ff830b0cb2b7eef832931de2d2bab56::m2 {
    struct M2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/E4n5gooEoFaDPb1oSDmN2VXjWKekrTn3EFE7KjNKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<M2>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"M2          ")))), trim_right(b"GLOBAL MONEY SUPPLY             "), trim_right(b"The vast power of the global money supply, harnessed in one cryptographic token                                                                                                                                                                                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M2>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M2>>(v4);
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

