module 0xca5ba133b3b47eaa3b8289f63d6b96703d2493420bb3c2fb6f850d646e249df2::yuna {
    struct YUNA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUNA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YUNA>>(0x2::coin::mint<YUNA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x55507fc855cabbaf4cc07ee8c3639c74b8a6cdfe.png?size=lg&key=503a8e                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YUNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YUNA    ")))), trim_right(b"Sense Of Yuna                   "), trim_right(b"AI-powered blockchain agent with ChainSense integration. Your waifu guide to explore crypto, track trades, master DeFi, and gain real-time AI insights. Enhances decision-making with precise blockchain analysis.                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUNA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YUNA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<YUNA>>(0x2::coin::mint<YUNA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

