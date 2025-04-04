module 0xc93de19ff18d7db1c10e42cb09a5cde5b3bdef3b5eec2c7e404eb8a9445d3013::jobseek {
    struct JOBSEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBSEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2sNvt9tRAW29cZgj3cVmwEGLJFfqb127GKnAiEN8iBxY.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JOBSEEK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JOBSEEK     ")))), trim_right(b"JobSeek AI                      "), trim_right(b"The world's 1st AI-powered job search platform is here! JobSeek AI Agent scans every job site in seconds & finds the perfect matchjust like Tinder, but for jobs. Powered by DeepSeek                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBSEEK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOBSEEK>>(v4);
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

