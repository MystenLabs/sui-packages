module 0xd9bbb52a1fb356afc4f944b3072602602f4b763cd6e840a2763957e26ed2e215::sui4ai {
    struct SUI4AI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI4AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI4AI>>(0x2::coin::mint<SUI4AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUI4AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4WFB4bEikmMsVZLsxAsnRiqms4yHSH48WAM29p9Spump.png?size=lg&key=2f489e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUI4AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUI4AI  ")))), trim_right(b"SUI4 AI                         "), trim_right(b"THE MOST POWERFUL AGENT AI Generate All About Content with Agent AI on Sui Blockchain Discover Our AI-Driven Website Template for Scalable, High-Quality Content Creation and Take Your Business to the Next Level                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI4AI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI4AI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI4AI>>(0x2::coin::mint<SUI4AI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

