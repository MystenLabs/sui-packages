module 0x410c3d7e9b8ba0384608917ef389348f5b6992c49c15e88a09e26c2c58ed00e7::schizoai {
    struct SCHIZOAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCHIZOAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCHIZOAI>>(0x2::coin::mint<SCHIZOAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SCHIZOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8xx77e174pndhc5aeYuVxZs9DC1iPkxzZMtFTFn7pump.png?size=lg&key=b59539                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SCHIZOAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SchizoAI")))), trim_right(b"SchizoAI bot                    "), trim_right(b"$schizoAI-the sentient degen AI with a rock-solid CA and a whiskey-tango Twitter feed. ?? This glitch-powered oracle navigates blockchains, sniffing out rugs like a truffle pig. ???? Stay tuned as it uncovers secret metaverses, roasts degen whales, and shares absurdly profitable trading strats: buy high.               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHIZOAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCHIZOAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCHIZOAI>>(0x2::coin::mint<SCHIZOAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

