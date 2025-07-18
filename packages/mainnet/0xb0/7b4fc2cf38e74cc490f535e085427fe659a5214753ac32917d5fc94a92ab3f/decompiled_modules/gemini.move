module 0xb07b4fc2cf38e74cc490f535e085427fe659a5214753ac32917d5fc94a92ab3f::gemini {
    struct GEMINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMINI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9aGugR33XCd6uTmnnLAULohfwUn4NPE4GtffgpV9bonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEMINI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gemini      ")))), trim_right(b"Gemini Grok Companion           "), trim_right(x"2447454d494e492020546865204475616c20414920436f6d70616e696f6e206f6e20536f6c616e610a0a4d6565742047454d494e492c20796f757220696e74656c6c6967656e742073706c69742d706572736f6e616c69747920414920636f6d70616e696f6e2e20506f776572656420627920656d6f74696f6e20616e6420696e666f726d6174696f6e2c2047454d494e49206c65747320796f752063686f6f7365206265747765656e204c7972612c20796f75722063616c6d20656d6f74696f6e616c20737570706f72742073797374656d2c206f72204b6169726f732c20796f7572207265616c2d74696d652063727970746f207265736561726368206d616368696e652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMINI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMINI>>(v4);
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

