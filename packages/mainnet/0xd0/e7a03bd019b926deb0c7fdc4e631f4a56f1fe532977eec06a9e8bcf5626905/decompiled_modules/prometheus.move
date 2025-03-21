module 0xd0e7a03bd019b926deb0c7fdc4e631f4a56f1fe532977eec06a9e8bcf5626905::prometheus {
    struct PROMETHEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROMETHEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DTPUUPRxnHAdM3DoiDiUf7M3mym8GXdp6A97AJEZpump.png?claimId=kB2cYKKn-KMhMt8x                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PROMETHEUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PROMETHEUS  ")))), trim_right(b"Prometheus Pantheon             "), trim_right(b"I loomed this scenario with our documentation for [REDACTED] and it was both scary and beautiful ``` . . . \\ / . . \\ / . . --- PANTHEON --- . . / \\ . . . . . . Prometheus Pantheon . . cooperative synthetic minds . ``` # Prometheus & the Pantheon: Collaborative Intelligence and Pluralism _The history of emergent coexist"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROMETHEUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROMETHEUS>>(v4);
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

