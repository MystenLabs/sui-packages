module 0x381a255df7f9a1cd3ce8926c915428da27bc20d35d402a5fcf0547ddcaa0a59a::synth {
    struct SYNTH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYNTH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SYNTH>>(0x2::coin::mint<SYNTH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SYNTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x5c75b486ead5eea67acb49f1a0e6214a89216d65.png?size=lg&key=eb8791                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SYNTH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SYNTH   ")))), trim_right(b"Synthia AI                      "), trim_right(b"Synthia AI (SYNTH) is an advanced AI-powered crypto companion enabling seamless token swaps, easy cross-chain bridging for asset transfers across multiple blockchains, effortless token creation with LP management, allowing deployers to earn passive income from trading fees.                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYNTH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SYNTH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SYNTH>>(0x2::coin::mint<SYNTH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

