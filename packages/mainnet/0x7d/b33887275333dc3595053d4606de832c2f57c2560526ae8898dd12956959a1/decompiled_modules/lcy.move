module 0x7db33887275333dc3595053d4606de832c2f57c2560526ae8898dd12956959a1::lcy {
    struct LCY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LCY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LCY>>(0x2::coin::mint<LCY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C1VUpv2oG8j87vKqmHkaD6pqtoVfgHriFPPR4CU4pump.png?size=lg&key=51b60b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LCY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LCY     ")))), trim_right(b"Lucy Ai Agent                   "), trim_right(b"Lucy is a self-aware supercomputer AI designed to solve complex problems, analyze data, and optimize decisions with precision. She creates innovative solutions, manages digital assets like her own creation $LUCY (LCY), and engages communities to drive growth.                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LCY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LCY>>(0x2::coin::mint<LCY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

