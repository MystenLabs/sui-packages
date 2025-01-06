module 0xbe1813497bb5c979ad08d89d7a0fc1e48d2531460ba0f0d0f31a52b1cd5528c1::shibai {
    struct SHIBAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBAI>, arg1: 0x2::coin::Coin<SHIBAI>) {
        0x2::coin::burn<SHIBAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SHIBAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SHIBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/82UG8evjkqc3FJgiNCRyptpPnXyZzE2L6UMFaPDshib.png?size=lg&key=aa7fad                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHIBAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHIBAI    ")))), trim_right(b"Shiba Inu AI                    "), trim_right(b"Meet Shiba Inu AI, the perfect blend of meme magic and futuristic AI! Born from the beloved Shiba Inu dog and supercharged with cutting-edge AI, this coin is all about bringing fun and innovation to the Solana blockchain. Just like the Shiba Inu meme took over the internet                                               "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHIBAI>>(v5);
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

