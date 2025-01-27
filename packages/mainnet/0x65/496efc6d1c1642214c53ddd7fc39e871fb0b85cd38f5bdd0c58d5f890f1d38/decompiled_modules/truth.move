module 0x65496efc6d1c1642214c53ddd7fc39e871fb0b85cd38f5bdd0c58d5f890f1d38::truth {
    struct TRUTH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUTH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUTH>>(0x2::coin::mint<TRUTH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2GmUPhpe93kcTJZrC7NJ2keeDZRT5dBveUgegb13pump.png?size=lg&key=1b7525                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUTH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRUTH   ")))), trim_right(b"TruthChain                      "), trim_right(b"TruthChain (truth) TruthChain is a project to decentralize LLM consensus and verify factual data. TruthChain solves the problem of checking LLMs for censorship and misinformation by comparing the outputs of LLMs against a decentralized network of hosted LLMs known to be neutral and untampered with.                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUTH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUTH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUTH>>(0x2::coin::mint<TRUTH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

