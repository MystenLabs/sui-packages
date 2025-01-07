module 0x9e7f7f1e9d6db9deebd3ad0a7f40a41190e3fa56f355178863b9db2b736b79ba::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAI>>(0x2::coin::mint<KAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xa045fe936e26e1e1e1fb27c1f2ae3643acde0171.png?size=lg&key=ca6f99                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KAI     ")))), trim_right(b"Kai Ken                         "), trim_right(b"Kai Ken is THE LAST INU! A community-owned meme coin inspired by the last breed of Japanese Inus. KAI was the only main Japanese dog breed without a coin. This makes the KAI narrative unique and non-replicable.                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KAI>>(0x2::coin::mint<KAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

