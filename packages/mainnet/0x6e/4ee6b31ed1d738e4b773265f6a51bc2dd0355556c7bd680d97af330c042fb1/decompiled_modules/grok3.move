module 0x6e4ee6b31ed1d738e4b773265f6a51bc2dd0355556c7bd680d97af330c042fb1::grok3 {
    struct GROK3 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GROK3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GROK3>>(0x2::coin::mint<GROK3>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GROK3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6ydBLn9Y21a6rp4ktuvyri8TeFX1dr4XyruqD7gspump.png?size=lg&key=0436c6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GROK3>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GROK3   ")))), trim_right(b"Grok 3                          "), trim_right(b"Grok 3 is an advanced AI model developed by xAI, designed to surpass its predecessors in computational power and capabilities. Trained on over 100,000 Nvidia H100 GPUs, it boasts 10X more compute power than Grok 2, aiming to set new standards in AI performance.                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK3>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GROK3>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GROK3>>(0x2::coin::mint<GROK3>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

