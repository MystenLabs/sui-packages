module 0x7d3d1e4587e9a3d0efa88840c07edf2eeb4bd63987e9ad0cd5aa0da0863591a1::grok3ai {
    struct GROK3AI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GROK3AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GROK3AI>>(0x2::coin::mint<GROK3AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GROK3AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FYDRoNCex7KJfYx3iHFhD9peJb4PPSB9EG7VAg4sUKBq.png?size=lg&key=288251                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GROK3AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GROK3AI ")))), trim_right(b"Grok 3 AI                       "), trim_right(b"Elon Musk announced on X that Grok 3, the latest AI chatbot from his company xAI, will be released with a live demo at 8pm PT on Monday (February 17, 2025). Musk claims that Grok 3 is the \"smartest AI on Earth\" and has very powerful reasoning capabilities, outperforming anything that has been released so far .         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK3AI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GROK3AI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GROK3AI>>(0x2::coin::mint<GROK3AI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

