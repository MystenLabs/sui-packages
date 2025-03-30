module 0x807b0f6b114a68fdffbc8cd59e90c590cd0756aab198d262d3f7269d267831dd::skinny {
    struct SKINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9oKRUyKhkUhnteBDeUY7VcsXG6wv79ghKDrAVoQppump.png?claimId=ddOEe9Eb-0CmfS8t                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SKINNY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SKINNY      ")))), trim_right(b"Skinny Nigga Season             "), trim_right(b"Skinny Nigga Season is the slickest token storming the streets  a lean, mean, profit-chasing machine! Built for the hustlers, the grinders, and the chart-toppers, this aint just a coin, its a lifestyle. We dodged the old CTOs fumble, took the reins, and now were sending it straight to the top. Fast trades, big gains, a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKINNY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKINNY>>(v4);
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

